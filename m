Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbRHaUvy>; Fri, 31 Aug 2001 16:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRHaUvo>; Fri, 31 Aug 2001 16:51:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22285 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269354AbRHaUve>; Fri, 31 Aug 2001 16:51:34 -0400
Subject: Re: kernel hangs in 118th call to vmalloc
To: ttabi@interactivesi.com (Timur Tabi)
Date: Fri, 31 Aug 2001 21:54:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B8FF671.1050804@interactivesi.com> from "Timur Tabi" at Aug 31, 2001 03:41:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cvJa-0003xz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > is able to get itself to the point it killed off all user space.
> 
> So you're saying it's a bug that I can't work around?

Its a design property vmalloc never had. It isnt meant to be abused that
way

> I heard that 2.4.9 doesn't even run "thrash".  Is this true?  If so, why 
> are these buggy VM's being released in the first place?

Lack of crystal balls.

The VM seemed ok until after 2.4.0 at which point it became clear it had
some rather large corner cases where it was not. Fixing them is an
iterative process and getting all cases right is hard. I'm very happy with
the 2.4.9-ac tree VM. It needs the inode cache handling resolved better
but it works
