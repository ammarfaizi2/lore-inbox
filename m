Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWJER0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWJER0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWJER0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:26:13 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:15770 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751722AbWJER0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:26:12 -0400
Date: Thu, 5 Oct 2006 11:26:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use linux/io.h instead of asm/io.h
Message-ID: <20061005172611.GB2563@parisc-linux.org>
References: <11600679551209-git-send-email-matthew@wil.cx> <45253EAE.2070600@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45253EAE.2070600@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 01:19:42PM -0400, Jeff Garzik wrote:
> Matthew Wilcox wrote:
> >In preparation for moving check_signature, change these users from
> >asm/io.h to linux/io.h
> 
> The vast majority of drivers include asm/io.h.

Yes.  linux/io.h was only created recently.  It's proper style to
include linux/foo.h when both linux/foo.h and asm/foo.h exist [1]
This is just a transition which hasn't been completed yet (indeed, has
barely begun).

> Wouldn't it be better to move check_signature to 
> include/asm-generic/io.h, and include that where needed?

I really don't think that proliferating header files unnecessarily is a
good idea.

[1] Except, of course, <linux/irq.h>, but I thought rmk was going to fix
that.
