Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSBGIEY>; Thu, 7 Feb 2002 03:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSBGIEO>; Thu, 7 Feb 2002 03:04:14 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:5606 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S285747AbSBGIEA> convert rfc822-to-8bit; Thu, 7 Feb 2002 03:04:00 -0500
Date: Thu, 7 Feb 2002 09:03:58 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: status on northbridge disconnection apm saving?
In-Reply-To: <Pine.LNX.4.44.0202070329290.1072-100000@grignard.amagerkollegiet.dk>
Message-ID: <Pine.LNX.4.40.0202070848450.14773-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Rasmus Bøg Hansen wrote:

> I just flashed my BIOS today (upgrading my Asus A7V133-C from BIOS
> rev. 1005A to rev. 1007). Suddenly I begin to experience the sound-skips
> reported by other people. The CPU is a TB (9x133, 1200MHz, family 6,
> model 4, stepping 2).
>
> Before flashing I had no trouble at all and the CPU cooled just fine, so
> it might not only be a chipset issue.
>
> I tried the new version of the patch and get:

> Athlon/Duron CLK_Ctrl Value found : fff0d22f
> Athlon/Duron CLK_Ctrl Value set to : fff0d22f

ahh ... the value already was set ... ok ... that means that this value is
not the right one for this cpu. i got some new informations which say that
you need different values for different cpus ... at the moment i wait
for an answer from amd. i send them an email and asked for some support on
this toppic. maybe i get the table withe the right settings.
until then i see no way to get further ... so we must wait what their
answer is ...

>
> I have no idea, what those register values were before flashing. When
> using the patch from www.vcool.de I experience the same problem - it was
> not present before either. I also experience the problem when running
> the user-land tool from www.vcool.de. It does not matter whether I
> specify force_amd_clk=yes or not.

yes ... of cause ... as you see above, the value it founds was already the
value i thought the patch has to programm. so there could be no difference
in the behavoir. maybe you could do some additional testing ?
could you please change some setting for the pci latency timer in bios or
so ? there were some discussions whether the skippy behavior has something
to do with dma transfers and maybe the latency setting could have
something to do with this. the problem is, that i have no possibility to
test this, cause my system has no problems at all with the patch ...

daniel


> No hardware changes nor kernel config changes were made.
>

i think the bios has changed some settings ... the new one handels
something different than the old one ... maybe you could send me both bios
files on my emailadress (no cc to lkml) and i will look whether i find
differences ? (haven't done this before, but maybe i find something)

> I send output of lspci along if it might help.
>
> Regards
> Rasmus

thank you for testing ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

