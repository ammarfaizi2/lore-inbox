Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752171AbWAEMBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbWAEMBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbWAEMBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:01:20 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:1213 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1752171AbWAEMBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:01:19 -0500
Date: Thu, 5 Jan 2006 13:01:11 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Jaroslav Kysela <perex@suse.cz>
cc: Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
Message-ID: <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-115217795-1136462471=:17086"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-115217795-1136462471=:17086
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 4 Jan 2006, Jaroslav Kysela wrote:

> On Wed, 4 Jan 2006, Pete Zaitcev wrote:
>
>> On Wed, 4 Jan 2006 09:37:55 +0000, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
>>
>>>> 2) ALSA API is to complicated: most applications opens single sound
>>>>    stream.
>>>
>>> FUD and nonsense. []
>>> http://devzero.co.uk/~alistair/alsa/
>>
>> That's the kicker, isn't it? Once you get used to it, it's a workable
>> API, if kinky and verbose. I have a real life example, too:
>>  http://people.redhat.com/zaitcev/linux/mpg123-0.59r-p3.diff
>> But arriving on the solution costed a lot of torn hair. Look at this
>> bald head here! And who is going to pay my medical bills when ALSA
>> causes me ulcers, Jaroslav?
>
> Well, the ALSA primary goal is to be the complete HAL not hidding the
> extra hardware capabilities to applications. So API might look a bit
> complicated for the first glance, but the ALSA interface code for simple
> applications is not so big, isn't?

Sorry Jaroslav byt this not unix way.
Wny applications myst know anything about hardware layer ?
In unix way all this details are rolled on kernel layer.

> Also, note that app developers are not forced to use ALSA directly - there
> is a lot of "portable" sound API libraries having an ALSA backend doing
> this job quite effectively. We can add a simple (like OSS) API layer
> into alsa-lib, but I'm not sure, if it's worth to do it. Perhaps, adding
> some support functions for the easy PCM device initialization might be
> a good idea.

If we have so many "portable" sound API libraries .. look most of them 
uses the same way for handle sound on kernel interaction. Is this 
complicated ALSA way is realy neccessary ?
For example .. jackd can use OSS API for handle sound device.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*

Allow me translate sentence from my signature to english
"People do not have problems they create them themselves"
and ALSA case matches in 100%.
--0-115217795-1136462471=:17086--
