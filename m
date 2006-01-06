Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752432AbWAFHhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbWAFHhq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWAFHhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:37:46 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:20569 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1752431AbWAFHhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:37:45 -0500
Message-ID: <43BE1E46.3060904@cosmosbay.com>
Date: Fri, 06 Jan 2006 08:37:42 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com> <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com> <43BB1178.7020409@cosmosbay.com> <p733bk4z2z0.fsf@verdi.suse.de> <43BBADD5.3070706@cosmosbay.com> <Pine.LNX.4.62.0601051900440.973@qynat.qvtvafvgr.pbz> <43BE0FC3.7030602@cosmosbay.com> <Pine.LNX.4.62.0601052318570.1708@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0601052318570.1708@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang a écrit :
> Ok, so if you have large numbers of CPU's and large page sizes it's not 
> useful. however, what about a 2-4 cpu machine with 4k page sizes, 8-32G 
> of ram (a not unreasonable Opteron system config) that will be running 
> 5,000-20,000 processes/threads?

Dont forget 'struct files_struct' are shared between threads of one process.

So may benefit from this 'special cache' only if you plan to run 20.000 processes.

> 
> I know people argue that programs that do such things are bad (and I 
> definantly agree that they aren't optimized), but the reality is that 
> some workloads are like that. if a machine is being built for such uses 
> configuring the kernel to better tolorate such use may be useful

If 20.000 process runs on a machine, I doubt the main problem of sysadmin is 
about the 'struct files_struct' placement in memory :)

Eric

