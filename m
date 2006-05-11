Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWEKPnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWEKPnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWEKPnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:43:41 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:33031 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030283AbWEKPnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:43:40 -0400
Message-ID: <44635BA8.9060002@argo.co.il>
Date: Thu, 11 May 2006 18:43:36 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 metadata performace
References: <4463461C.3070201@conterra.de>
In-Reply-To: <4463461C.3070201@conterra.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 May 2006 15:43:38.0850 (UTC) FILETIME=[AC13A420:01C67511]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stüken wrote:
> after I switched from from ext2 to ext3 i observed some severe 
> performance degradation. Most discussion about this topic deals
> with tuning of data-io performance. My problem however is related to 
> metadata updates. When cloning (cp -al) or deleting directory trees I 
> find, that about 7200 files are created/deleted per minute. Seems
> this is related to some ex3 strategy, to wait for each metadata to be
> written to disk. Interestingly this occurs with my new hw-raid
> controller (3ware 9500S), which even has an battery buffered disk cache.
> Thus there is no need for synchronous IO anyway. If I disable the
> disk cache on my plain SATA disk using ext3, I also get this behavior.
>
Try increasing the journal size (mkfs -t ext3 -J size=20000) and see if 
that improves things.

-- 
error compiling committee.c: too many arguments to function

