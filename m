Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277218AbRJDUfA>; Thu, 4 Oct 2001 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277216AbRJDUeu>; Thu, 4 Oct 2001 16:34:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27151 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277212AbRJDUem>; Thu, 4 Oct 2001 16:34:42 -0400
Subject: Re: Security question: "Text file busy" overwriting executables but
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 4 Oct 2001 21:39:46 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110040142270.26177-100000@weyl.math.psu.edu> from "Alexander Viro" at Oct 04, 2001 01:44:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pFHW-00041w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 4 Oct 2001, Linus Torvalds wrote:
> 
> > The reason the kernel refuses to honour it, is that MAP_DENYWRITE is an
> > excellent DoS-vehicle - you just mmap("/etc/passwd") with MAP_DENYWRITE,
> > and even root cannot write to it.. Vary nasty.
> 
> <nit>
> I _really_ doubt that something does write() on /etc/passwd.  Create a
> file and rename it over the thing - sure, but that's it.
> </nit>

The MAP_DENYWRITE rule was added a long time ago because people found actual
workable DoS attacks
