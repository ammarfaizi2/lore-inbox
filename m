Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283114AbRK2JQ1>; Thu, 29 Nov 2001 04:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283115AbRK2JQS>; Thu, 29 Nov 2001 04:16:18 -0500
Received: from [212.18.232.186] ([212.18.232.186]:30478 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283114AbRK2JQB>; Thu, 29 Nov 2001 04:16:01 -0500
Date: Thu, 29 Nov 2001 09:15:48 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
Message-ID: <20011129091548.B5686@flint.arm.linux.org.uk>
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C057410.3090201@us.ibm.com> <20011128234505.C2561@flint.arm.linux.org.uk> <3C0580A8.5030706@us.ibm.com> <20011129004113.D2561@flint.arm.linux.org.uk> <3C059087.9070900@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C059087.9070900@us.ibm.com>; from haveblue@us.ibm.com on Wed, Nov 28, 2001 at 05:33:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 05:33:59PM -0800, David C. Hansen wrote:
> Does everyone agree that we need to get the BKL out of common areas like 
> this?  For starters, what about adding a pair of spinlocks for block 
> devices and character devices to take the place of the BKL in 
> serializing opens?  Or, should we make it the driver's responsibility 
> completely?

If you do happen to look at the serial driver, please note that I'm
currently working on a replacement driver, in cvs at:

   :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot, module serial
   (no password)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

