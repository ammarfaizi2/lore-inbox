Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWB1O7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWB1O7Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWB1O7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:59:16 -0500
Received: from ns2.suse.de ([195.135.220.15]:16101 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751179AbWB1O7P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:59:15 -0500
Message-ID: <44046542.9030209@suse.de>
Date: Tue, 28 Feb 2006 15:59:14 +0100
From: Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] Fixup ahci suspend / resume
References: <44045FB1.5040408@suse.de> <44046222.4090008@rtr.ca>
In-Reply-To: <44046222.4090008@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Hannes Reinecke wrote:
>> Hi all,
>>
[ .. ]
>> This patch rearranges the suspend / resume code to properly initialise
>> those registers after a resume. It also contains some initialisation
>> fixes to make the driver behave more spec-compliant.
> ..
> 
> Is ahci the *only* interface afflicted with this problem?
Good question.

Can't tell. So far this is ahci specific as the ahci requires the DMA
addresses to be written in some register. One would have to look up the
individual specs to check whether this is also true for other drivers.

AFAICS the SATA spec doesn't require you to implement it this way, though.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

