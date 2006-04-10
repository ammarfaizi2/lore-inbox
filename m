Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWDJN1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWDJN1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWDJN1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:27:19 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:43851 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750993AbWDJN1T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:27:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZQuWEXrVwmuMTehM/7eJJKZK+dJC+lwhm+bRHalBODCMH9iT9fZSWtBJ+7rvW9aMevHcHJ9TKHqq6K951EpevttZJquOseaOO1E/vL+3iedYIR70xekDWt18aWotHRlpEbTTKvL3UOHNiCfxUetApXuNr0sJ5lmZCW8Z/NRxtD8=
Message-ID: <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com>
Date: Mon, 10 Apr 2006 21:27:18 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Erik Mouw" <erik@harddisk-recovery.com>
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060410112817.GE12896@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com>
	 <20060410112817.GE12896@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Mon, Apr 10, 2006 at 06:16:56PM +0800, Aubrey wrote:
> Why would you write a driver in assembly in the first place? That makes
> it highly unportable, I bet you can't compile your driver for x86 and
> ARM from the same source. There are only four drivers in the whole
> kernel tree that have an assembly part, but those are so tied to their
> platform (Acorn, Amiga) that they aren't portable anyway.

Yes, the driver isn't portable. I'm working on the blackfin linux
system. The driver is written mostly by c except one codec. You know,
blackfin has DSP instruction set, so I write the codec in assembly to
improve my driver's performance.
>
> I haven't seen your Makefile so I can't see what's wrong, but see
> drivers/scsi/arm/Makefile for an example.
>
Makefile is simple.
===============================
----snip----
obj-$(CONFIG_FB_BFIN_7171)	  += bfin_ad7171fb.o rgb2ycbcr.o
----snip----
===============================
There are two files, bfin_ad7171fb.c and rgb2ycbcr.S under the folder
" ./drivers/video".
It should be OK because the driver can pass the compilation when
select it as built-in.
It just failed when select it as module.

Thanks your any hints.


Regards,
-Aubrey
