Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTAVPWo>; Wed, 22 Jan 2003 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTAVPWo>; Wed, 22 Jan 2003 10:22:44 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.20]:24660 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261529AbTAVPWn>; Wed, 22 Jan 2003 10:22:43 -0500
Message-ID: <3E2EB962.9020503@users.sf.net>
Date: Wed, 22 Jan 2003 16:31:46 +0100
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with Qlogic 2200 and 2.4.20
References: <20030122094015$6b19@gated-at.bofh.it>
In-Reply-To: <20030122094015$6b19@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Przemys³aw Maciuszko wrote:
> Hello.
> I have a strange problem with 2.4.20 (also 2.4.19) and Qlogic FC 2200.
> 
> The machine runs test news-server, so disk load is high.
> After few minutes of running I get the following errors on console:
> 
> qlogifc0 : no handle slots, this should not happen
> hostdata->queued is 19, in_ptr: 63
> qlogifc0 : no handle slots, this should not happen
> hostdata->queued is 19, in_ptr: 6a
> qlogifc0 : no handle slots, this should not happen
> hostdata->queued is 19, in_ptr: 70
> 
> and so on.

This is a long standing problem. Andrew Patterson gave a patch on the list:

http://groups.google.com/groups?selm=linux.scsi.1019759258.2413.1.camel%40lvadp.fc.hp.com

Without this patch, 2.4.18 would lock up in a few minutes syncing a software 
raid. With the patch, it has been running multiple megabytes I/O a second for 
months. And yes it can sync software RAIDs too.

The driver seems to be working for some people without the patch, but the 
problem appears so quickly on some systems that it is strange the fix has not 
been incorporated yet. In my case, I tested with ISP2200 cards and a JBOD with 
Cheetah 10k4 and 10k5 drives.


Thomas

