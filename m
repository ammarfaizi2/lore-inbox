Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277150AbRJDFot>; Thu, 4 Oct 2001 01:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276973AbRJDFoj>; Thu, 4 Oct 2001 01:44:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61161 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277133AbRJDFo3>;
	Thu, 4 Oct 2001 01:44:29 -0400
Date: Thu, 4 Oct 2001 01:44:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <9pgsk4$7ep$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110040142270.26177-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Linus Torvalds wrote:

> The reason the kernel refuses to honour it, is that MAP_DENYWRITE is an
> excellent DoS-vehicle - you just mmap("/etc/passwd") with MAP_DENYWRITE,
> and even root cannot write to it.. Vary nasty.

<nit>
I _really_ doubt that something does write() on /etc/passwd.  Create a
file and rename it over the thing - sure, but that's it.
</nit>

