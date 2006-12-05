Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968434AbWLEQqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968434AbWLEQqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968439AbWLEQqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:46:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58200 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968434AbWLEQqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:46:23 -0500
Message-ID: <4575A170.2030805@redhat.com>
Date: Tue, 05 Dec 2006 11:42:24 -0500
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       stefanr@s5r6.in-berlin.de
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	<1165297363.29784.54.camel@localhost.localdomain> <20061204.230502.35014139.davem@davemloft.net>
In-Reply-To: <20061204.230502.35014139.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 05 Dec 2006 16:42:42 +1100
> 
>>  - It's horribly broken in at least two area :
>>
>>  DO NOT USE BITFIELDS FOR DATA ON THE WIRE !!!
>>
>>  and
>>
>>  Where do you handle endianness ? (no need to shout for
>>  that one).
>>
>> (Or in general, do not use bitfields period ....)
> 
> Yes, this is a show stopper, the endianness and
> word-size/endian testing should have been done before
> submission.

I guess my mistake here was to present it as a patch submission.  I 
acknowledged in my cover letter that it wasn't feature complete and I'm not 
pushing for inclusion just yet.  I'm very much aware of the point that when 
replacing a subsystem like this, the new code has to be as good as the old 
code.  In that respect, the patches I posted are lacking in other areas 
(isochronous streaming is the big one) that will take more work to fix than 
just making it work on big-endian and 64-bit architectures.  It's still a work 
in progress.

Having said that, I've been working on this for a while now, and I wanted to 
announce the effort and open the discussion about replacing the old stack. 
Something about "release early, release often"... :)  Anyway, I've moved the 
portability issues to the top of my list now.

Kristian

