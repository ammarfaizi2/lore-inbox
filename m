Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTDYHxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 03:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTDYHxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 03:53:25 -0400
Received: from dsl0206.netquest.net ([206.117.109.206]:36305 "EHLO
	arcadia.augart.com") by vger.kernel.org with ESMTP id S263489AbTDYHxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 03:53:24 -0400
Message-ID: <3EA8EC4D.4090506@augart.com>
Date: Fri, 25 Apr 2003 01:05:33 -0700
From: Steven Augart <steve@augart.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030423
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Simple x86 Simulator (was: Re: Flame Linus to a crisp!)
References: <200304250702.h3P72FZF000352@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200304250702.h3P72FZF000352@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We could not.  Consider just the 8 32-bit-wide legacy x86 registers, 
excluding the MMX and FPU registers:
(AX, BX, CX, DX, BP, SI, DI, SP).  32 bits x 8 = 2^256 independent 
states to look up in the table, each state having 256 bits of 
information.  2^264 total bits of information needed.  Assume 1 GB dimms 
(2^30 * 8 bits each = 2^33 bits of info), with a volume of 10 cm^3 per 
DIMM (including a tiny amount of space for air circulation.).
Need 34508731733952818937173779311385127262255544860851932776 cubic 
kilometers of space.

Considerably larger than the volume of the earth, although admittedly 
smaller than the total volume of the universe. 

--Steven Augart



John Bradford wrote:

>>>I'd like to see an x86 completely in perf board. I thought my high
>>>school digital electronics type stuff looked bad...
>>>      
>>>
>>You could do it nowadays using dynamic binary translation, and an
>>absurdly simple CPU capable of accessing a large memory.  You'd need a
>>DIMM for the large memory, but get away with discrete logic for the
>>CPU if you really wanted to.
>>
>>At perf board sizes using discrete logic, expect it run run quite slow :)
>>    
>>
>
>Could we not take this idea to it's logical extreme, and simply
>calculate the results of every opcode, on every value, for every state
>of all of the registers, and store them in an array of DIMMs, and
>simply look up the necessary results?  I.E. a cpu which is one _huge_
>look up table :-).
>
>John.
>  
>

