Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbTCTKUL>; Thu, 20 Mar 2003 05:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTCTKUJ>; Thu, 20 Mar 2003 05:20:09 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:32653 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261369AbTCTKUH>; Thu, 20 Mar 2003 05:20:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
Date: Thu, 20 Mar 2003 11:30:07 +0100
User-Agent: KMail/1.5
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
References: <20030320001013$67af@gated-at.bofh.it> <200303200136.h2K1aDsD001827@post.webmailer.de> <20030320023843.GA22795@wotan.suse.de>
In-Reply-To: <20030320023843.GA22795@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303201130.07163.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 March 2003 03:38, Andi Kleen wrote:

> This would work for COMPATIBLE_IOCTLS, but the conversions handlers
> would need a new asm/ file for the macros. 

If this is just about HANDLE_IOCTL, IOCTL_TABLE_START etc., they look 
trivial enough to be put in asm/compat.h. They even appear to be
arch independent even though they have inline asm.

>                                            They're declared with assembler
> magic to avoid declaring all the functions. This way you need less files.
Ah, I have always wondered why it is done in such a strange way for some
architectures.

	Arnd <><
