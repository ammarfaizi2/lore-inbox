Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTLXDFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 22:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTLXDFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 22:05:43 -0500
Received: from skintwin.microway.com ([64.80.227.45]:58286 "EHLO
	skintwin.microway.com") by vger.kernel.org with ESMTP
	id S262882AbTLXDFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 22:05:30 -0500
Message-ID: <3FE901D5.4000306@mail.ru>
Date: Tue, 23 Dec 2003 22:02:45 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: aacraid issues
References: <3FE8CD8D.6090303@mail.ru> <1072222521.25288.3.camel@markh1.pdx.osdl.net>
In-Reply-To: <1072222521.25288.3.camel@markh1.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp wrote:
> On Tue, 2003-12-23 at 15:19, Yaroslav Klyukin wrote:
> 
>>I have very strange aacraid behavior:
>>First of all, I know, that aacraid support is experimental, but maybe 
>>the issue is related to something else in the kernel.
>>
>>I have AMD Opteron system with 10 scsi disks, connected to Adaptec 2200S 
>>controller, constituting about 1.2TB in total.
>>
>>I can boot with 2.4.22 kernel, compiled for Xeon, into RedHat 9
>>(32 bit mode). aacraid version 1.1.2. The raid works great.
>>
>>Then I boot into SuSE Linux 9 for the Opterons, with 2.4.23 kernel.
>>aacraid version 1.1-3.
>>
>>Seems to work, but when I try to access blocks close to the end of the 
>>RAID, I am getting I/O errors.
>>
>>Any ideas?
>>Where can I get the latest patches for the aacraid driver?
>>
>>Just tried 2.6.0 kernel with patches for Opteron, but as soon as it 
>>starts working with Adaptec controller, it crashes miserably... :-(
>>
> 
> 
> Try this, someone else with a 2200 had a similar problem that this patch
> fixed. It will apply to 2.6.0.

Thank you very much, I will try it tomorrow.
Is there anything for 2.4.23?

> 
> 
> 
> 
> ===== drivers/scsi/aacraid/aachba.c 1.20 vs edited =====
> --- 1.20/drivers/scsi/aacraid/aachba.c	Fri May  2 12:30:49 2003
> +++ edited/drivers/scsi/aacraid/aachba.c	Wed Dec  3 15:10:22 2003
> @@ -525,6 +525,14 @@
>  	if(dev->pae_support != 0) {
>  		printk(KERN_INFO"%s%d: 64 Bit PAE enabled\n", dev->name, dev->id);

