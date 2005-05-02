Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVEBOf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVEBOf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 10:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVEBOf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 10:35:27 -0400
Received: from magic.adaptec.com ([216.52.22.17]:16877 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261272AbVEBOfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 10:35:19 -0400
Message-ID: <42763AA1.7040508@adaptec.com>
Date: Mon, 02 May 2005 10:35:13 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Douglas Gilbert <dougg@torque.net>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
References: <425D392F.2080702@adaptec.com> <20050424111908.GA23010@infradead.org> <426D1572.70508@adaptec.com> <20050425161411.GA11938@infradead.org> <426D2723.8070308@adaptec.com> <20050425181831.GA14190@infradead.org> <426E5BAF.4040003@adaptec.com> <426F86D3.4070909@torque.net> <20050429100848.GB3342@infradead.org>
In-Reply-To: <20050429100848.GB3342@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2005 14:35:15.0523 (UTC) FILETIME=[27CF2130:01C54F24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/05 06:08, Christoph Hellwig wrote:
> Note that the current scsi code allows to create custom per-transport
> objects below the target object.  We're using that in the fibre channel
> transport class for the concept of remote ports.

Yes, I've been meaning to ask about this... since a SAS host adapter
(class) has ports (class?) which has phys (class), so there's this
hierarchy between those to-be transport classes.

Is this doable given the current infrastructure?

(I guess when it comes down to it one can represent a sub-class as
 an "attribute" or even as a linked list...) 
 
>>Once the SAS discovery algorithm has been run should we
>>show its results in sysfs??
> 
> 
> I think so, yes.  Similar to how we have all fibre channel remote ports
> in sysfs, even if they are not scsi targets.

Ok, we can show this from each HA (/sys/class/sas_ha/...) but you do not
want the existence of /sys/bus/sas/... where things are consolidated.
I guess that's ok, and if needed, it can always be implemented later.

	Luben
