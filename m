Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbTLCOJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTLCOJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 09:09:41 -0500
Received: from h1ab.lcom.net ([216.51.237.171]:52104 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S264560AbTLCOJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 09:09:37 -0500
Date: Wed, 3 Dec 2003 08:09:33 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.6.0-test11 and CS4236 card
Message-ID: <20031203140932.GD27034@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org
References: <20031202170637.GD5475@digitasaru.net> <s5hsmk3ceia.wl@alsa2.suse.de> <20031203031749.GB27034@digitasaru.net> <s5hd6b6cf7m.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hd6b6cf7m.wl@alsa2.suse.de>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Takashi Iwai on Wednesday, 03 December, 2003:
>Hi,
>At Tue, 2 Dec 2003 21:17:51 -0600,
>Joseph Pingenot wrote:
>> THE BAD NEWS:
>> -------------
>> Both times (with your patch and with isapnp), I had the following problems:
>>   a) xmms wouldn't talk straight to the card even after selecting the alsa
>>        output plugin
>what was the error exactly?

Standard thing when it can't talk to the sound card:

"Please check that:
  1. You have the correct output plugin selected
  2. No other programs is(sic) blocking the soundcard
  3. Your soundcard is configured properly
  
         [OK]"

FWIW, ALSA for the cs4281 chip on my home box works 100%, and xmms can talk
  to it without problem.  These are different distros (gentoo@home, debian@work)
  so it may also be a problem in Debian, but I don't think so.

>>   b) I started esd (the alsa version) and then told xmms to talk to esd.
>>        It worked out well for a couple of seconds, but then it crashed
>>        (both with your patch and with the manually activated (isapnp) one)
>>        
>>        It crashed HARD.
>oh, that's bad.

Ja.  I'm gonna have to sort it out whenever I can get my homework done.
  Either this afternoon or tomorrow.  Just gotta copy some files over by
  floppy (e.g. route) and then tar them over from another machine.

>>        It crashed so hard that it wiped out some files, like apt, I presume
>>          when it was cleaning "orphans" in /; the net result is that my
>> 	 box is semi-hosed, since things like tr and apt-get and route
>> 	 are now full of '\0' characters instead of their actual contents.
>> 
>> Sound played for about a second, then the machine hung hard (I don't think
>>   that the Magic SysRq keys even did anything), and the last couple of
>>   tenths of a second of sound just repeated over and over and over until
>>   I hit reset.  I don't have an oops; it was highly hosed.
>> 
>> When I can pull my system back together, I can try again.  Please help
>>   me find this new bug, so that the cs4236 driver is safe for other
>>   Dell P410 users!  :)
>i'm puzzled because cs4236's pcm code is basically identical with
>cs4231, and cs4232 seems working (at least the last time i tested).
>anyway, please show the kernel config and check any other apps do
>similar oops / crash.

Hmm.  I dunno.  The only odd thing atm is that the nvidia driver was loaded
  and had reported a couple of bugs.  When the machine's up next time,
  I'll try it sans nvidia and see what we get.  I don't suspect that's the
  problem, as everything but sound worked 100%, but we'll see.

Other than my diagnostic print statements or your pnp patch, everything
  at runtime was vanilla (except nvidia of course)

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
