Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbVINRRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVINRRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbVINRRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:17:49 -0400
Received: from magic.adaptec.com ([216.52.22.17]:60130 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965254AbVINRRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:17:48 -0400
Message-ID: <43285B2A.5040107@adaptec.com>
Date: Wed, 14 Sep 2005 13:17:30 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: Douglas Gilbert <dougg@torque.net>,
       James Bottomley <James.Bottomley@SteelEye.com>, ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com> <1126368081.4813.46.camel@mulgrave> <4325997D.3050103@adaptec.com> <20050912162739.GA11455@us.ibm.com> <4326964B.9010503@torque.net> <20050913224215.GB1308@us.ibm.com> <4328176D.80307@adaptec.com> <20050914171307.GA10044@us.ibm.com>
In-Reply-To: <20050914171307.GA10044@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2005 17:17:37.0098 (UTC) FILETIME=[3401C2A0:01C5B950]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/05 13:13, Patrick Mansfield wrote:
> On Wed, Sep 14, 2005 at 08:28:29AM -0400, Luben Tuikov wrote:
> 
>>On 09/13/05 18:42, Patrick Mansfield wrote:
> 
> 
>>>What I mean is that the target has to intercept the command whether it is
>>>a REPORT LUN or for the well known (W_LUN).
>>>
>>>The target (firmware) code has to have code today like:
>>>
>>>	if (cmd == REPORT_LUN) {
>>>		do_report_lun();
>>>	}
>>>
>>>For only W_LUN support, the code might be something like:
>>>
>>>	if (lun == W_LUN) {
>>>		if (cmd == REPORT_LUN) {
>>>			do_report_lun();
>>>		}
>>>	}
>>>
>>>But the first case above already covers even the W_LUN case.
>>
>>_Except_, that what the firmware actually does is, it routes
>>the tasks by LUN first, _before_ looking up with what the command
>>is.*  This is crucial.
> 
> 
> That is what the second code snippet above is meant to show.

It was completely unclear what you meant since your code was
scattered in English text and you did not mention that
firmware does LU routing first, to quote:
     "The target (firmware) code has to have code today like:"

>>>So adding a W_LUN at this point does not add any value ... maybe it looks
>>>nice in the spec and in someones firmware, but it does not add anything
>>>that I can see.
>>
>>I wonder if the maintainer of the SCSI Core would listen or ignore your
>>opinion here.
> 
> 
>>I wonder _who_ decides here where speculation ends and industry
>>opinion starts?
> 
> 
> I am talking about the scsi spec, not the code. IMO linux scsi code should
> support W_LUN and 64 bit LUN.

Ok, that's good.

	Luben
