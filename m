Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUCKIkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUCKIkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:40:14 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:2944 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S262641AbUCKIkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:40:07 -0500
Message-ID: <4050271C.3070103@brad-x.com>
Date: Thu, 11 Mar 2004 03:45:16 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
References: <404F85A6.6070505@brad-x.com> <20040310155712.7472e31c.akpm@osdl.org>
In-Reply-To: <20040310155712.7472e31c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Please ensure that the machine was booted with `profile=1' on
> the kernel boot command line.  The cost of this is negligible.
> 
> When the problem starts happening, run:
> 
> sudo readprofile -r
> sleep 10
> sudo readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40
> 
> (make sure that /boot/System.map refers to the currently-running kernel)


Gave the machine a bit of a workout to create the problem sooner than 
usual, albeit on a smaller scale. ksoftirqd consumed about 4.7% of the 
CPU according to top after several concurrent wget operations, and had 
accumulated about 6 seconds of runtime, unheard of for a system uptime 
of 15 minutes; the output attached is during this.

Hopefully I'm right in assuming that; on all other systems I've 
experimented with ksoftirqd doesn't even flinch unless subjected to 
extremes.

Did some further testing with a machine of identical configuration 
(suffers the same issue too); removed iptables from the suspects list, 
as the issue exists sans those modules.

Hopefully the attached shows some irregularity. If not, I'll have to 
reply back in a few weeks when the problem recurs over the course of time.

Cheers,
Brad
