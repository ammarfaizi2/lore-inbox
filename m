Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265553AbSJXQw1>; Thu, 24 Oct 2002 12:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265552AbSJXQw1>; Thu, 24 Oct 2002 12:52:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:2944 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265553AbSJXQwZ>;
	Thu, 24 Oct 2002 12:52:25 -0400
Subject: Re: 2.5.44-ac2: stack overflow in acpi_initialize_objects
From: "David C. Hansen" <haveblue@us.ibm.com>
To: ebuddington@wesleyan.edu
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021024102034.A102@ma-northadams1b-3.bur.adelphia.net>
References: <20021024102034.A102@ma-northadams1b-3.bur.adelphia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Oct 2002 09:56:59 -0700
Message-Id: <1035478619.9081.17.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 07:20, Eric Buddington wrote:
> 2.5.44-ac2 compiled for Athlon with gcc-3.2 fails to boot with a
> really exciting stack overflow that dumps hordes of stack trace on the
> screen. I'm too lazy to write it all down, but the last line before
> 'init' refers to acpi_initialize_objects.
> 
> I can write down more of it if needed.

Does it panic, or just print out a lot of the traces?  

If it panics, then you were able to chew through 7.5K of stack while it
warned during the last 3.5k.  Could you give us an idea of what was
being called?  Something like "a bunch of ACPI routines" or "the same
function a bunch of times" would be very helpful.  For right now, just
turn the CONFIG_X86_STACK_CHECK config option off.

-- 
Dave Hansen
haveblue@us.ibm.com

