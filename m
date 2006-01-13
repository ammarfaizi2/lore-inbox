Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161495AbWAMIcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161495AbWAMIcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWAMIcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:32:04 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:16857 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161495AbWAMIcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:32:02 -0500
Message-ID: <43C76623.7060906@in.ibm.com>
Date: Fri, 13 Jan 2006 14:04:43 +0530
From: Sachin Sant <sachinp@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3
References: <20060111042135.24faf878.akpm@osdl.org>
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/

I got this compile time error on a powerpc box.

...
   CC [M]  drivers/usb/input/mtouchusb.o
   CC [M]  drivers/usb/input/powermate.o
   CC [M]  drivers/usb/input/wacom.o
drivers/usb/input/wacom.c:98: error: conflicting types for `G4'
include/asm/cputable.h:37: error: previous declaration of `G4'
make[3]: *** [drivers/usb/input/wacom.o] Error 1
make[2]: *** [drivers/usb/input] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

Problem seems to be because of the following in 
include/asm-powerpc/cputable.h

enum powerpc_oprofile_type {
         INVALID = 0,
         RS64 = 1,
         POWER4 = 2,
         G4 = 3,     <====Defined here
         BOOKE = 4,
};


Thanks
-Sachin
