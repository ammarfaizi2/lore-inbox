Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWBHVEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWBHVEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBHVEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:04:00 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:46836 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932409AbWBHVEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:04:00 -0500
Message-ID: <43EA5CBE.3020801@comcast.net>
Date: Wed, 08 Feb 2006 16:03:58 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata pata atapi  errors
References: <43E95415.40501@comcast.net> <1139399874.26270.8.camel@localhost.localdomain>
In-Reply-To: <1139399874.26270.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Maw, 2006-02-07 at 21:14 -0500, Ed Sweetman wrote:
>  
>
>>Assertion failed! qc->n_elem > 
>>0,drivers/scsi/libata-core.c,ata_fill_sg,line=2586
>>   (repeated many times)
>>    
>>
>
>
>Jeff was looking at some core bugs in this area. Its one of the ones I
>can I think safely disclaim responsibility for (that and the fact that a
>timeout of a command early on in 2.6.16-rc causes an oops)
>
>Alan
>
>  
>

Well, I was able to eventually recover the drive so that it responds 
without any errors and functions correctly.  Though, writing seems to be 
pretty much out of service.   Whenever i try writing anymore (haven't 
rebooted yet since the last errors) all it does is make a strange noise 
like the lens motor is trying to seek beyond it's limits and then I get 
the same series of errors that i originally got. 

If it helps any, I had to run a sg_sync on the drive to eventually get 
it back into a workable state.   Maybe it's having some sort of buffer 
problem that's not being internally flushed or cleared ?  I dont know.
