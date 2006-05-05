Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWEESSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWEESSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 14:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWEESSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 14:18:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:20203 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751196AbWEESSU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 14:18:20 -0400
Message-ID: <445B96E1.3080401@zytor.com>
Date: Fri, 05 May 2006 11:18:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bugs aren't features: X86_FEATURE_FXSAVE_LEAK
References: <445B7EF0.6090708@zytor.com> <p733bfo5ol1.fsf@bragg.suse.de>
In-Reply-To: <p733bfo5ol1.fsf@bragg.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> The recent fix for the AMD FXSAVE information leak had a problematic
>> side effect.  It introduced an entry in the x86 features vector which
>> is a bug, not a feature.
> 
> It's a non issue because it affects all AMD CPUs (except K5/K6).
> You'll never find a system where only some CPUs have this problem.
> 

It's still wrong architecturally, and we should have a sane way to deal with this as well 
as other bugs.  This isn't the only bug -- we're getting a decent-size collection of them 
already -- and not all of them is going to have that particular property.

	-hpa

