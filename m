Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVJEMHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVJEMHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbVJEMHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:07:48 -0400
Received: from free.hands.com ([83.142.228.128]:14247 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S965139AbVJEMHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:07:45 -0400
Date: Wed, 5 Oct 2005 13:07:27 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005120727.GV10538@lkcl.net>
References: <mail.linux.kernel/20051003203037.GG8548@lkcl.net> <05Oct4.173802edt.33143@gpu.utcc.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05Oct4.173802edt.33143@gpu.utcc.utoronto.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 05:37:59PM -0400, Chris wrote:

> You write:
> |  personally i find that i like a bit of a run-up and/or advance notice
> |  of major paradigm shifts.
> 
>  I maintain that one of the problems is that we simply do not know how
> to efficiently (in all senses of the word) program multi-processing
> systems and applications. Various people have various theories about how
> it should be done, but they are not well-proven.
> 
>  We do know that the current approach is difficult and error-prone, but
> terribly attractive because of an at least superficial simplicity. So
> far none of the alternatives have been convincing enough to supplant it.
> 
>  Efficient changing of paradigms requires a target paradigm. In this
> environment, a good target paradigm does not appear to exist yet and
> may not be clear for years. Starting engineering work seems a little
> bit premature in that situation.
 
 chris,

 your words paraphrase nicely the issues faced - for software engineers.

 however, if you were to speak to a hardware engineer - an embedded
 systems designer of ASICs - they would have a completely different
 take on it, because they are dealing with parallelism all the time,
 _and_ they even have some tools to help them do that.

 what those ASIC designers lack is an off-the-shelf affordable
 multiprocessor chip that makes their parallel algorithms run
 fast enough: they _have_ to go for custom ASIC.

 which is where the pricing of 90nm - $250k mask charges making up most
 of the $2m NREs - is so key.  even .13micron you're looking at $200k
 NREs [non-recoverable expenditure].
 
 and if you were to do a chip at .13micron you would be
 looking at 120 watts for something running at 800mhz with
 only 1 million gates.
 
 a pentium 3 800mhz in other words, and that won't exactly get you very
 far.


 what the software engineers you refer to above lack is the toolchain to
 assist them in developing for anything other than uniprocessor targets.

 such tools and techniques are being researched and developed (i sent
 references to a coupl and also a google search criteria in another
 earlier LKML email): however, yet again, it's chicken-and-egg.

 until the chips start going multiprocessor, the tools are going to
 remain in research labs.  until the tools come out of research labs,
 the chips are going to remain useless.

 where it all goes a bit pearshaped with that chicken-and-egg vicious
 cycle is if the bottom drops out of 65nm and 45nm processes, such that
 _even_ the top uniprocessor mass-market chip manufacturers are forced
 down a parallel processing line.

 my point is: we're starting to see evidence of that happening
 (small-scale, 2-cores, 2-hyperthreads, talk of 4-cores, etc.
  even the X-Box 360 PPC 3x2)

 _therefore_, i invite people who do linux kernel development
 to think ahead - to take a _lead_ for once instead of waiting
 for hardware to drop into their laps, at which point it is once
 again too late, the hardware design decisions will have
 already been made by someone else, and you will be treated
 like second class citizens.  again.

 l.

