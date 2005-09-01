Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVIAR1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVIAR1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVIAR1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:27:09 -0400
Received: from astro.systems.pipex.net ([62.241.163.6]:12447 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1030256AbVIAR1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:27:07 -0400
Message-ID: <431739D2.6060709@tungstengraphics.com>
Date: Thu, 01 Sep 2005 18:26:42 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: Brian Paul <brian.paul@tungstengraphics.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
References: <9e47339105083009037c24f6de@mail.gmail.com>	<1125422813.20488.43.camel@localhost>	<20050831063355.GE27940@tuolumne.arden.org>	<1125512970.4798.180.camel@evo.keithp.com>	<20050831200641.GH27940@tuolumne.arden.org>	<1125522414.4798.222.camel@evo.keithp.com>	<20050901015859.GA11367@tuolumne.arden.org>	<1125547173.4798.289.camel@evo.keithp.com>	<43171D33.9020802@tungstengraphics.com>	<1125590991.15768.55.camel@localhost.localdomain>	<4317268B.20306@tungstengraphics.com> <43173894.7040304@us.ibm.com>
In-Reply-To: <43173894.7040304@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Romanick wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Brian Paul wrote:
> 
> 
>>It's other (non-orientation) texture state I had in mind:
>>
>>- the texel format (OpenGL has over 30 possible texture formats).
>>- texture size and borders
>>- the filtering mode (linear, nearest, etc)
>>- coordinate wrap mode (clamp, repeat, etc)
>>- env/combine mode
>>- multi-texture state
> 
> 
> Which is why it's such a good target for code generation.  You'd
> generate the texel fetch routine, use that to generate the wraped texel
> fetch routine, use that to generate the filtered texel fetch routine,
> use that to generate the env/combine routines.
> 
> Once-upon-a-time I had the first part and some of the second part
> written.  Doing just that little bit was slightly faster on a Pentium 3
> and slightly slower on a Pentium 4.  I suspect the problem was that I
> wasn't caching the generated code smart enough, so it was it trashing
> the CPU cache.  The other problem is that, in the absence of an
> assembler in Mesa, it was really painful to change the code stubs.

Note that the last part is now partially addressed at least - Mesa has 
an integrated and simple runtime assembler for x86 and sse.  There are 
some missing pieces and rough edges, but it's working and useful as it 
stands.

Keith
