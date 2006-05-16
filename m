Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWEPWg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWEPWg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWEPWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:36:28 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:52871 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932222AbWEPWg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:36:27 -0400
Message-ID: <446A53DE.6060400@de.ibm.com>
Date: Wed, 17 May 2006 00:36:14 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation prerequisite
References: <446A1023.6020108@de.ibm.com> <20060516112824.39b49563.akpm@osdl.org>
In-Reply-To: <20060516112824.39b49563.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Peschke <mp3@de.ibm.com> wrote:
>> need sched_clock for latency statistics
> 
> sched_clock() probably isn't suitable for this application.  It's a
> scheduler thing and has a number of accuracy problems.
> 
> But I thought we discussed this last time around?  Maybe not.

I have been too obsessed with the other issues to remember.

 > Maybe you've considered sched_clock()'s drawbacks and you've decided
 > they're all acceptable.

Admittedly, I didn't, but merely believed the comment above the function.

http://marc.theaimsgroup.com/?l=linux-kernel&m=114657675408686&w=2
sheds some light.

I would be happy to exploit an API that may result from that discussion.
I would plead for exporting such an API to modules. I don't see how
to implement statistics for latencies, otherwise.

Any other hints on how to replace my sched_clock() calls are welcome.
(I want to measure elapsed times in units that are understandable to
users without hardware manuals and calculator, such as milliseconds.)

Martin

