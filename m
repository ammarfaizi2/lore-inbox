Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVEBOaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVEBOaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 10:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVEBOaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 10:30:30 -0400
Received: from magic.adaptec.com ([216.52.22.17]:744 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261271AbVEBOaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 10:30:21 -0400
Message-ID: <42763975.8010103@adaptec.com>
Date: Mon, 02 May 2005 10:30:13 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       dougg@torque.net, Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
References: <425D392F.2080702@adaptec.com> <20050424111908.GA23010@infradead.org> <426D1572.70508@adaptec.com> <20050425161411.GA11938@infradead.org> <426D2723.8070308@adaptec.com> <20050425181831.GA14190@infradead.org> <426E5BAF.4040003@adaptec.com> <20050429100525.GA3342@infradead.org>
In-Reply-To: <20050429100525.GA3342@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2005 14:30:15.0611 (UTC) FILETIME=[750C30B0:01C54F23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/05 06:05, Christoph Hellwig wrote:
> Sure, quoting your initial mail:
> 
> /----------------------------------------------------------------------
> | 2. Sysfs SAS Domain
> | -------------------
> |
> | Represent everything which "sits out there" in the SAS
> | domain, irrespective of how you connect to it.
> |
> | /sys/bus/sas/
> | /sys/bus/sas/<WWN_ta0>/
> | /sys/bus/sas/<WWN_ta0>/phys/
> |
> | ...
> \----------------------------------------------------------------------
> 
> Here you have a global hiearchy.  We are not interested in that, though -
> we only care for what's visible from a certain HBA.

True, it is a "global" hierarchy.  But visiblity from a single HBA
is also present in /sys/class/sas_ha/... .
 
>>Overall, since the discovery process gets (internally) a "picture"
>>of the domain out there, it would be appropriate to show this
>>"picture" to the user.
> 
> Absolutely. 

Ok, so then we want some kind of "global" representation?
Since the discover process (in its attempt to discover topology
errors) would have to know little or less about the "global" outlook.

	Luben

