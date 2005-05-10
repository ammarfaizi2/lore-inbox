Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVEJTR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVEJTR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVEJTRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:17:55 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:15775 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261748AbVEJTRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:17:01 -0400
Message-ID: <4280E613.20801@tmr.com>
Date: Tue, 10 May 2005 12:49:23 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Ricky Beam <jfbeam@bluetronic.net>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <427FA557.3030400@tmr.com> <20050509195804.GD2297@csclub.uwaterloo.ca>
In-Reply-To: <20050509195804.GD2297@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Mon, May 09, 2005 at 02:00:55PM -0400, Bill Davidsen wrote:
> 
>>Linus did what was probably right then. I would agree that there is room 
>>for something better now. Just to prove it could be done (not that this 
>>is the only or best way):
> 
> 
> I suspect many architecture's /proc/cpuinfo were not decided by Linus at
> all, but by whoever ported linux to that architecture.
> 
> 
>>  cpu0 {
>>    socket: 0
>>    chip-cache: 0
>>    num-core: 2
>>    per-core-cache: 512k
>>    num-siblings: 2
>>    sibling-cache: 0
>>    family: i86
>>    features: sse2 sse3 xxs bvd
>>    # stepping and revision info
>>  }
>>  cpu1 {
>>    socket: 1
>>    chip-cache: 0
>>    num-core: 1
>>    pre-core-cache: 512k
>>    num-siblings: 2
>>    sibling-cache: 64k
>>    family: i86
>>    features: sse2 sse3 xxs bvd kook2
>>    # stepping and revision info
>>  }
> 
> 
> Where does numa nodes fit into that?
> 
> 
>>This is just proof of concept, you can have per-chip, per-core, and 
>>per-sibling cache for instance, but I can't believe that anyone would 
>>make a chip where the cache per core or per sibling differed, or the 
>>instruction set, etc. Depending on where you buy your BS, Intel and AMD 
>>will (or won't) make single and dual core chips to fit the same socket.
> 
> 
> Have you seen the Cell processor?  Multi core with different instruction
> set for the smaller execution cores than the main one.

I'm aware of it, but until someone actually produces a multicore which 
executes the same instruction set (386+P4?) I assume that all the cores 
used by the program will be the same.

I wrote for the DEC Rainbow (8086 and Z80, one did disk and video, one 
did serial+net), and IIRC the memory addresses were shared but the IO 
addresses weren't. Also something I can't easily name which had a 68010 
and 4 bit RISC in a single carrier. Early microcomputer days were fun, 
or at least I thought it was fun to cope with bizarre and unreliable 
hardware when I was young.

