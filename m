Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbVKPD6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbVKPD6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbVKPD6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:58:54 -0500
Received: from mail.dvmed.net ([216.237.124.58]:30896 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965230AbVKPD6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:58:53 -0500
Message-ID: <437AAE75.7090202@pobox.com>
Date: Tue, 15 Nov 2005 22:58:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379E5F7.6000107@gmail.com> <4379EC82.1030509@pobox.com> <437AA1A0.6080409@gmail.com> <437AA51A.6000709@pobox.com> <437AAC0B.80106@rtr.ca>
In-Reply-To: <437AAC0B.80106@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>>
>> My setup works without it, successfully burning CDs and DVDs, but has 
>> problems with really long commands, and such those which occur when 
>> cdrecord(1) finishes a CD burn, and performs its "fixating" step.
> 
> 
> Is this just a case of too-short of a SCSI timeout on CLOSE_TRACK?
> Drivers I have worked on for this generally apply a 2 minute timeout
> for that particular operation, and never have to retry.

I haven't narrowed it down yet.  I see the timeout handler kick in, when 
burning CDs and on one other random occasion.  There is clearly a 
timeout real/expectations mismatch somewhere.

	Jeff



