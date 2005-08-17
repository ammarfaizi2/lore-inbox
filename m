Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVHQHrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVHQHrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 03:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVHQHrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 03:47:17 -0400
Received: from [194.90.79.130] ([194.90.79.130]:40458 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750957AbVHQHrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 03:47:17 -0400
Message-ID: <4302EB80.7060705@argo.co.il>
Date: Wed, 17 Aug 2005 10:47:12 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: HDAPS, Need to park the head for real
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de>
In-Reply-To: <20050816200708.GE3425@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2005 07:47:13.0440 (UTC) FILETIME=[E18CFA00:01C5A2FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>Ok, I'll give you some hints to get you started... What you really want
>to do, is:
>
>- Insert a park request at the front of the queue
>- On completion callback on that request, freeze the block queue and
>  schedule it for unfreeze after a given time
>
>  
>
how will this interact with command queuing? there is a danger from both 
commands previously queued but not yet completed, and commands that are 
queued after the park request. or is the park request a barrier?
