Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282266AbRK2BeR>; Wed, 28 Nov 2001 20:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282269AbRK2BeH>; Wed, 28 Nov 2001 20:34:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24309 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282266AbRK2Bdz>; Wed, 28 Nov 2001 20:33:55 -0500
Message-ID: <3C059087.9070900@us.ibm.com>
Date: Wed, 28 Nov 2001 17:33:59 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011128
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C057410.3090201@us.ibm.com> <20011128234505.C2561@flint.arm.linux.org.uk> <3C0580A8.5030706@us.ibm.com> <20011129004113.D2561@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>The BKL is only held for the duration of the open, not until you close the
>device.
>
I'll need to go back and review the changes to the char and block 
devices.  I believe that a big chunk of the drivers that we changed were 
misc drivers, so I might still be in luck.

Does everyone agree that we need to get the BKL out of common areas like 
this?  For starters, what about adding a pair of spinlocks for block 
devices and character devices to take the place of the BKL in 
serializing opens?  Or, should we make it the driver's responsibility 
completely?

Dave Hansen
haveblue@us.ibm.com

