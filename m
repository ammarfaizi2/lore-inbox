Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWH3R6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWH3R6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWH3R6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:58:39 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:7893 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751277AbWH3R6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:58:38 -0400
Date: Wed, 30 Aug 2006 10:52:02 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Olaf Hering <olaf@aepfle.de>
cc: Michael Buesch <mb@bu3sch.de>, Greg KH <greg@kroah.com>,
       Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060830054433.GA31375@aepfle.de>
Message-ID: <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> 
 <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz>  <20060829183208.GA11468@kroah.com>
 <200608292104.24645.mb@bu3sch.de>  <20060829201314.GA28680@aepfle.de> 
 <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz> <20060830054433.GA31375@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006, Olaf Hering wrote:

>> you are assuming that
>>
>> 1. modules are enabled and ipw2200 is compiled as a module
>
> No, why?

becouse if the ipw isn't compiled as a module then it's initialized (without 
firmware) before the initramfs or initrd is run. if it could be initialized 
later without being a module then it could be initialized as part of the normal 
system

>> 2. initrd or initramfs are in use
>
> initramfs is always in use.

not on my machines.

what does it use for the initramfs?

I don't enable the options in the kernel for initrd, and I don't give it any 
source for an initramfs.

David Lang

P.S. there was a suggestion yesterday in this thread that I haven't tested yet. 
I plan to test that tonight. if it works then the card can be reinitialized 
after the system boots, still no initrd or initramfs needed.
