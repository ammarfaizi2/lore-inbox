Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbUDRICD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 04:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbUDRICD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 04:02:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47627 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264060AbUDRICA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 04:02:00 -0400
Date: Sun, 18 Apr 2004 09:01:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix unix module
Message-ID: <20040418090157.B4239@flint.arm.linux.org.uk>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@osdl.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1082266361.14879.27.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1082266361.14879.27.camel@bach>; from rusty@rustcorp.com.au on Sun, Apr 18, 2004 at 03:32:42PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 03:32:42PM +1000, Rusty Russell wrote:
> The compiler #define's unix to 1: we use -DKBUILD_MODNAME=unix.  We
> used to #undef unix at the top of af_unix.c, but now the name is
> inserted by modpost, that doesn't help.

Do we depend on this preprocessor symbol anywhere?  If not, adding
-Uunix to the global CFLAGS would prevent future "accidents".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
