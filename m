Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWCBJwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWCBJwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWCBJwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:52:03 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:44165 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751425AbWCBJwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:52:00 -0500
Message-ID: <4406C044.4080201@drzeus.cx>
Date: Thu, 02 Mar 2006 10:52:04 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43DA97A3.4080408@drzeus.cx> <20060127225428.GD2767@flint.arm.linux.org.uk> <20060128191759.GC9750@suse.de> <43DBC6E2.4000305@drzeus.cx> <20060129152228.GF13831@suse.de> <43DDC6F9.6070007@drzeus.cx> <20060130080930.GB4209@suse.de> <43DFAEC6.3090205@drzeus.cx> <20060301232913.GC4024@flint.arm.linux.org.uk> <44069E3A.4000907@drzeus.cx> <20060302094153.GA14017@flint.arm.linux.org.uk>
In-Reply-To: <20060302094153.GA14017@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Mar 02, 2006 at 08:26:50AM +0100, Pierre Ossman wrote:
>   
>> Russell King wrote:
>>     
>>> Okay, I've hit this same problem (but in a slightly different way) with
>>> mmci.c.  The way I'm proposing to fix this for mmci is to introduce a
>>> new capability which says "clustering is supported by this driver."
>>>       
>> This will decrease performance more than necessary for drivers that can
>> do clustering, just not in highmem. So what about another flag that says
>> "highmem is supported by this driver"?
>>     
>
> I think you're asking Jens that question - I know of no way to tell
> the block layer that clustering is fine for normal but not highmem.
>
>   

That wasn't what I meant. What I was referring to was disabling highmem
altogether, the way that is done now through looking at the dma mask.

Rgds
Pierre

