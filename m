Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbUKFWdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUKFWdH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 17:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUKFWdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 17:33:07 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:14091 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261492AbUKFW3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 17:29:48 -0500
Message-ID: <418D4268.8000409@conectiva.com.br>
Date: Sat, 06 Nov 2004 19:30:16 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bloat
References: <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl> <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041106120716.GA9144@pclin040.win.tue.nl> <Pine.LNX.4.58.0411060922260.2223@ppc970.osdl.org> <20041106193605.GL1295@stusta.de> <20041106214147.GA9663@pclin040.win.tue.nl> <20041106220753.GQ1295@stusta.de>
In-Reply-To: <20041106220753.GQ1295@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adrian Bunk wrote:
> On Sat, Nov 06, 2004 at 10:41:47PM +0100, Andries Brouwer wrote:
> 
>>On Sat, Nov 06, 2004 at 08:36:08PM +0100, Adrian Bunk wrote:
>>
>>
>>>It's even harder because some subsystem maintainers refuse to remove 
>>>unused global functions that might be used at some point far in the 
>>>future or that even are never intended for in-kernel usage...
>>
>>I have one or two unused functions inside #if 0 in sddr09.c.
>>Finding out the proper hardware details was nontrivial,
>>it would be a pity to throw the knowledge away.
>>But of course there is never a reason to have an unused function
>>appear in the binary. It is only source bloat.
> 
> 
> No disagreement on this issue.
> 
> But unused global functions that are even EXPORT_SYMBOL'ed like in the 
> ACPI and FireWire cases are not only source bloat...

I agree with Andries that a reasonably small number of lines with
Pure Bloat (aka, not used at all) can stay as source bloat, #ifdefed,
but disagree on it getting lost if removed from the kernel, these days
once something gets in the kernel for at least one release it can be
fairly considered written in stone, with so many mirrors, source
navigation sites, search engines that open all kinds of files looking
for any sequence of letters or even pictures, sounds, etc.

Some years ago, when working with IPX I thought about looking at
finishing Jay Schullist initial work on SPX, but after some time I
just gave up and deleted the thing from mainline, but it is easly
retrievable in case somebody has any kind of interest.

Regards,

- Arnaldo

PS.: Bitrotting is just a small side effect, of course 8)
