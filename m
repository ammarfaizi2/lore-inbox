Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269863AbUIDJqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269863AbUIDJqC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269857AbUIDJp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:45:56 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:40115 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269854AbUIDJpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:45:41 -0400
Message-ID: <41398EBD.2040900@tungstengraphics.com>
Date: Sat, 04 Sep 2004 10:45:33 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org>
In-Reply-To: <20040904102914.B13149@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Sep 04, 2004 at 01:51:24AM +0100, Dave Airlie wrote:
> 
>>>Then drm_core would always be bundled with the OS.
>>>
>>>Is there any real advantage to spliting core/library and creating three
>>>interface compatibily problems?
>>
>>Yes we only have one binary interface, between the core and module, this
>>interface is minimal, so AGP won't go in it... *ALL* the core does is deal
>>with the addition/removal of modules, the idea being that the interface is
>>very minor and new features won't change it...
> 
> 
> Umm, the Linux kernel isn't about minimizing interfaces.  We don't link a
> copy of scsi helpers into each scsi driver either, or libata into each sata
> driver.

But regular users don't tend to pull down new scsi or ata drivers in the same 
way that they do graphics drivers.  Hence the concern of many drm developers 
to avoid introducing new failure modes in this process.

People who'd never dream of upgrading their kernel have acquired the habit of 
pulling down up-to-date video drivers on a weekly or monthly basis.  So, for 
sanity's sake, the DRI/DRM has been in the business of minimizing exposed 
interfaces, and for my money, should continue to be in that business.

Keith
