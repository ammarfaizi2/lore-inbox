Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTHOMUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275914AbTHOMUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:20:36 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:29700 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263930AbTHOMTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:19:50 -0400
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <00d001c36327$4a6d7e70$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Paul Nasrat" <pauln@truemesh.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <003701c3630f$387a6330$401a71c3@izidor> <20030815103529.GQ13037@shitake.truemesh.com> <00a501c3631c$676237b0$401a71c3@izidor> <20030815113940.GR13037@shitake.truemesh.com>
Subject: Re: 2.6.0test3mm2 - Synaptics touchpad problem
Date: Fri, 15 Aug 2003 14:18:08 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00CD_01C36338.0D607710"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00CD_01C36338.0D607710
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,
here are logs with debug enabled - working and not working.
I think the most interesitng part from the notworking is this:

<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [285]
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [285]
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [287]
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [287]
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [290]
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [290]
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, bad
parity, timeout) [295]
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [295]
<7>drivers/input/serio/i8042.c: ed -> i8042 (parameter) [295]
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, bad
parity, timeout) [298]
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [298]
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [298]
<7>drivers/input/serio/i8042.c: fe <- i8042 (flush, aux) [300]
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [300]
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [300]
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [303]
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [303]
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, bad
parity, timeout) [308]
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [308]
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [308]
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, bad
parity, timeout) [311]

Full logs are attached.
    Milan Roubal

----- Original Message ----- 
From: "Paul Nasrat" <pauln@truemesh.com>
To: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
Cc: "Andrew Morton" <akpm@osdl.org>; <linux-kernel@vger.kernel.org>
Sent: Friday, August 15, 2003 1:39 PM
Subject: Re: 2.6.0test3mm2 - Synaptics touchpad problem


> On Fri, Aug 15, 2003 at 01:00:09PM +0200, Milan Roubal wrote:
> > Hi,
> > I am using the new drivers for XFree86 and if the touchpad is visible
>
> Apologies I misread your bug report.  Maybe this will be of more help.
>
> > in dmesg, than it is working in XFree86 too. When it isn't,
> > it isn't than listed in /proc/bus/input/devices and is not working in
> > XFree86.
>
> That does seem odd, I haven't noticed this with vanilla 2.6.0test3
> (linux only, but a reboot linux->linux would exhibit that).
>
> I note on the non synaptics boot you have this instead of the synaptics.
>
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
>
> It may be worth #define DEBUG in i8042.c, to see the differences between
> the two boot sequences in more detail.
>
> You might want to try against 2.6.0-test3, if it works for you
> then it might be worth going through the synaptics patches in mm2 one by
> one :(
>
>
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/broken-out/
>
>
http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test2/v1/Readme.txt
>
> I'll see if I can replicate this with my laptop this evening.
>
> Paul
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_00CD_01C36338.0D607710
Content-Type: application/octet-stream;
	name="touchpad-debug-working"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="touchpad-debug-working"

Cannot find map file.=0A=
No module symbols loaded - kernel modules not enabled.=0A=
=0A=
Cannot build symbol table - disabling symbol lookups=0A=
klogd 1.4.1, log source =3D ksyslog started.=0A=
: f6 -> i8042 (parameter) [209]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [211]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [211]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [211]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [214]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [214]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [214]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [216]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [216]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [216]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [219]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [219]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [219]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [221]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [221]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [221]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [224]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [224]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [224]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [227]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [227]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [227]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [229]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [229]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [229]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [232]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [232]=0A=
<7>drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [232]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [234]=0A=
<7>drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, aux3, 12) [236]=0A=
<7>drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux3, 12) [237]=0A=
<7>drivers/input/serio/i8042.c: 15 <- i8042 (interrupt, aux3, 12) [238]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [238]=0A=
<7>drivers/input/serio/i8042.c: ff -> i8042 (parameter) [238]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [241]=0A=
<7>drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux3, 12) [630]=0A=
<7>drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [632]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [632]=0A=
<7>drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [632]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [634]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [634]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [634]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [637]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [637]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [637]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [639]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [639]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [639]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [642]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [642]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [642]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [645]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [645]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [645]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [647]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [647]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [647]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [650]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [650]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [650]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [652]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [652]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [652]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [655]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [655]=0A=
<7>drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [655]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [657]=0A=
<7>drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, aux3, 12) [659]=0A=
<7>drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux3, 12) [660]=0A=
<7>drivers/input/serio/i8042.c: 15 <- i8042 (interrupt, aux3, 12) [661]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [661]=0A=
<7>drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [661]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [664]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [664]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [664]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [666]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [666]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [666]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [669]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [669]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [669]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [671]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [671]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [671]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [674]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [674]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [674]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [677]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [677]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [677]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [679]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [679]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [679]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [682]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [682]=0A=
<7>drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [682]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [684]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [684]=0A=
<7>drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [684]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [687]=0A=
<7>drivers/input/serio/i8042.c: 92 <- i8042 (interrupt, aux3, 12) [688]=0A=
<7>drivers/input/serio/i8042.c: 44 <- i8042 (interrupt, aux3, 12) [689]=0A=
<7>drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, aux3, 12) [691]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [691]=0A=
<7>drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [691]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [693]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [693]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [693]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [696]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [696]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [696]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [698]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [698]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [698]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [701]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [701]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [701]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [703]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [703]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [703]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [706]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [706]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [706]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [709]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [709]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [709]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [711]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [711]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [711]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [714]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [714]=0A=
<7>drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [714]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [716]=0A=
<7>drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux3, 12) [718]=0A=
<7>drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, aux3, 12) [719]=0A=
<7>drivers/input/serio/i8042.c: 1b <- i8042 (interrupt, aux3, 12) [720]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [720]=0A=
<7>drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [720]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [723]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [723]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [723]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [725]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [725]=0A=
<7>drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [725]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [728]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [728]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [728]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [730]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [730]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [730]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [733]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [733]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [733]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [736]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [736]=0A=
<7>drivers/input/serio/i8042.c: 01 -> i8042 (parameter) [736]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [738]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [738]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [738]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [741]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [741]=0A=
<7>drivers/input/serio/i8042.c: 01 -> i8042 (parameter) [741]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [743]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [743]=0A=
<7>drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [743]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [746]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [746]=0A=
<7>drivers/input/serio/i8042.c: 14 -> i8042 (parameter) [746]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [748]=0A=
<6>Synaptics Touchpad, model: 1=0A=
<6> Firmware: 5.6=0A=
<6> 180 degree mounted touchpad=0A=
<6> Sensor: 18=0A=
<6> new absolute packet format=0A=
<6> Touchpad has extended capability bits=0A=
<6> -> four buttons=0A=
<6> -> multifinger detection=0A=
<6> -> palm detection=0A=
<6>input: Synaptics Synaptics TouchPad on isa0060/serio4=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [773]=0A=
<7>drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [773]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [775]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [775]=0A=
<7>drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [775]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [778]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [778]=0A=
<7>drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [778]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [781]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [781]=0A=
<7>drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [781]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [783]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [783]=0A=
<7>drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [783]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [786]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [786]=0A=
<7>drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [786]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [788]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [788]=0A=
<7>drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [788]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [791]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [791]=0A=
<7>drivers/input/serio/i8042.c: ea -> i8042 (parameter) [791]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [793]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [793]=0A=
<7>drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [793]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [796]=0A=
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [798]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [798]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [798]=0A=
<7>drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [798]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [798]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [801]=0A=
<7>drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [801]=0A=
<7>drivers/input/serio/i8042.c: 83 <- i8042 (interrupt, kbd, 1) [806]=0A=
<7>drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [806]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [809]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [809]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [812]=0A=
<7>drivers/input/serio/i8042.c: f8 -> i8042 (kbd-data) [812]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [815]=0A=
<7>drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [815]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [818]=0A=
<7>drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [818]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [820]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [820]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [823]=0A=
<7>drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [823]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [826]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [826]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [829]=0A=
<7>drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, kbd, 1) [829]=0A=
<6>input: AT Set 2 keyboard on isa0060/serio0=0A=
<6>serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
<6>NET4: Linux TCP/IP 1.0 for NET4.0=0A=
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes=0A=
<6>TCP: Hash tables configured (established 32768 bind 65536)=0A=
<6>IPv4 over IPv4 tunneling driver=0A=
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
<6>cpufreq: No CPUs supporting ACPI performance management found.=0A=
<6>ACPI: (supports S0 S3 S4 S5)=0A=
<5>RAMDISK: Compressed image found at block 0=0A=
<6>Freeing initrd memory: 348k freed=0A=
<4>VFS: Mounted root (ext2 filesystem).=0A=
<4>found reiserfs format "3.6" with standard journal=0A=
<4>Reiserfs journal params: device hda1, size 8192, journal first block =
18, max trans len 1024, max batch 900, max commit age 30, max trans age =
30=0A=
<4>reiserfs: checking transaction log (hda1) for (hda1)=0A=
<4>Using r5 hash to sort names=0A=
<4>VFS: Mounted root (reiserfs filesystem) readonly.=0A=
<5>Trying to move old root to /initrd ... failed=0A=
<5>Unmounting old root=0A=
<5>Trying to free ramdisk memory ... okay=0A=
<6>Freeing unused kernel memory: 172k freed=0A=
<6>Adding 514040k swap on /dev/hda6.  Priority:42 extents:1=0A=
<6>NTFS driver 2.1.4 [Flags: R/O MODULE].=0A=
<6>NTFS volume version 3.1.=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [9397]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [10398]=0A=
<7>drivers/input/serio/i8042.c: 5a <- i8042 (interrupt, kbd, 1) [13306]=0A=
<7>drivers/input/serio/i8042.c: f0 <- i8042 (interrupt, kbd, 1) [13398]=0A=
<7>drivers/input/serio/i8042.c: 5a <- i8042 (interrupt, kbd, 1) [13403]=0A=
<4>blk: queue ddd79e00, I/O limit 4095Mb (mask 0xffffffff)=0A=
<4>hdc: Disabling (U)DMA for SAMSUNG CD-ROM SN-124=0A=
Kernel logging (ksyslog) stopped.=0A=
Kernel log daemon terminating.=0A=
=0A=
Boot logging started on /dev/tty1(/dev/console) at Fri Aug 15 16:06:48 =
2003=0A=
=0A=
modprobe: FATAL: Module block_major_9 not found.=0A=
=0A=
=0A=
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel=0A=
Run file system check on root for LVM activation=0A=
doneRemounting root file system (/) read/write for vgscan...=0A=
Scanning for LVM volume groups...=0A=
modprobe: FATAL: Module char_major_109 not found.=0A=
=0A=
=0A=
vgscan -- LVM driver/module not loaded?=0A=
=0A=
Activating LVM volume groups...=0A=
modprobe: FATAL: Module char_major_109 not found.=0A=
=0A=
=0A=
modprobe: FATAL: Module char_major_109 not found.=0A=
=0A=
=0A=
vgchange -- LVM driver/module not loaded?=0A=
=0A=
done=0A=
Activating swap-devices in /etc/fstab...=0A=
doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel=0A=
Checking file systems...=0A=
fsck 1.28 (31-Aug-2002)=0A=
Reiserfs super block in block 16 on 0x301 of format 3.6 with standard =
journal=0A=
Blocks (total/free): 1536207/4141 by 4096 bytes=0A=
Filesystem is clean=0A=
doneMounting local file systems...=0A=
proc on /proc type proc (rw)=0A=
devpts on /dev/pts type devpts (rw,mode=3D0620,gid=3D5)=0A=
/sys on /sys type sysfs (rw)=0A=
/dev/hda3 on /windows type ntfs =
(ro,nosuid,nodev,nls=3Diso8859-2,umask=3D000)=0A=
doneActivating crypto devices using /etc/cryptotab ... =0A=
FATAL: Module loop_fish2 not found.=0A=
Please enter passphrase for /dev/hda5. failedLoading required kernel =
modules=0A=
doneSetting up IDE DMA mode=0A=
=0A=
/dev/hda:=0A=
 setting using_dma to 1 (on)=0A=
 using_dma    =3D  1 (on)=0A=
=0A=
/dev/hdc:=0A=
 setting using_dma to 1 (on)=0A=
 using_dma    =3D  1 (on)=0A=
done=0A=
Restore device permissionsdone=0A=
Activating remaining swap-devices in /etc/fstab...=0A=
doneSetting up the CMOS clockmodprobe: FATAL: Module char_major_10_135 =
not found.=0A=
=0A=
=0A=
modprobe: FATAL: Module char_major_10_135 not found.=0A=
=0A=
=0A=
done=0A=
Setting up timezone datadone=0A=
Setting up hostname 'izidor'done=0A=
Setting up loopback interface done=0A=
Disabling IP forwardingdone=0A=
Creating /var/log/boot.msg=0A=
doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel=0A=
<notice>killproc: kill(30,29)=0A=
Running /etc/init.d/boot.local=0A=
=0A=
/dev/hda:=0A=
 setting 32-bit IO_support flag to 1=0A=
 setting unmaskirq to 1 (on)=0A=
 setting standby to 60 (5 minutes)=0A=
 IO_support   =3D  1 (32-bit)=0A=
 unmaskirq    =3D  1 (on)=0A=
/etc/init.d/boot.local: line 16: /proc/sys/dev/rtc/max-user-freq: No =
such file or directory=0A=
failed<notice>killproc: kill(30,3)=0A=
=0A=

------=_NextPart_000_00CD_01C36338.0D607710
Content-Type: application/octet-stream;
	name="touchpad-debug-not-working"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="touchpad-debug-not-working"

Cannot find map file.=0A=
No module symbols loaded - kernel modules not enabled.=0A=
=0A=
Cannot build symbol table - disabling symbol lookups=0A=
klogd 1.4.1, log source =3D ksyslog started.=0A=
K=0A=
<6>CPU: L2 cache: 512K=0A=
<7>CPU:     After all inits, caps: 3febf9ff 00000000 00000000 00000080=0A=
<6>Intel machine check architecture supported.=0A=
<6>Intel machine check reporting enabled on CPU#0.=0A=
<6>CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available=0A=
<6>CPU#0: Thermal monitoring enabled=0A=
<4>CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04=0A=
<6>Enabling fast FPU save and restore... done.=0A=
<6>Enabling unmasked SIMD FPU exception support... done.=0A=
<6>Checking 'hlt' instruction... OK.=0A=
<4>POSIX conformance testing by UNIFIX=0A=
<4>Initializing RT netlink socket=0A=
<6>PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=3D1=0A=
<6>PCI: Using configuration type 1=0A=
<6>mtrr: v2.0 (20020519)=0A=
<4>BIO: pool of 256 setup, 15Kb (60 bytes/bio)=0A=
<4>biovec pool[0]:   1 bvecs: 256 entries (12 bytes)=0A=
<4>biovec pool[1]:   4 bvecs: 256 entries (48 bytes)=0A=
<4>biovec pool[2]:  16 bvecs: 256 entries (192 bytes)=0A=
<4>biovec pool[3]:  64 bvecs: 256 entries (768 bytes)=0A=
<4>biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)=0A=
<4>biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)=0A=
<6>ACPI: Subsystem revision 20030714=0A=
<4> tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully =
acquired=0A=
<4>Parsing all Control =
Methods:.................................................................=
.................................................=0A=
<4>Table [DSDT](id F004) - 405 Objects with 39 Devices 114 Methods 12 =
Regions=0A=
<4>ACPI Namespace successfully loaded at root c0437c9c=0A=
<4>evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode =
successful=0A=
<4>evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs =
at 0000000000008020 on int 11=0A=
<4>evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs =
at 0000000000008030 on int 11=0A=
<4>Completing Region/Field/Buffer/Package =
initialization:..........................................................=
.................=0A=
<4>Initialized 12/12 Regions 5/5 Fields 33/33 Buffers 25/25 Packages =
(413 nodes)=0A=
<4>Executing all Device _STA and_INI =
methods:........................................=0A=
<4>40 Devices found containing: 40 _STA, 2 _INI methods=0A=
<6>ACPI: Interpreter enabled=0A=
<6>ACPI: Using PIC for interrupt routing=0A=
<6>ACPI: PCI Root Bridge [PCI0] (00:00)=0A=
<4>PCI: Probing PCI hardware (bus 00)=0A=
<6>Enabling SiS 96x SMBus.=0A=
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]=0A=
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs *5)=0A=
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs *10)=0A=
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 5, disabled)=0A=
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs *11)=0A=
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs *11)=0A=
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 10, disabled)=0A=
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 10, disabled)=0A=
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs *10)=0A=
<6>ACPI: Embedded Controller [EC] (gpe 23)=0A=
<6>Linux Plug and Play Support v0.97 (c) Adam Belay=0A=
<7>pnp: the driver 'system' has been registered=0A=
<5>SCSI subsystem initialized=0A=
<6>Linux Kernel Card Services 3.1.22=0A=
<6>  options:  [pci] [cardbus] [pm]=0A=
<4>ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10=0A=
<4>ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11=0A=
<4>ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10=0A=
<4>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11=0A=
<4>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10=0A=
<4>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5=0A=
<4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5=0A=
<6>PCI: Using ACPI for IRQ routing=0A=
<6>PCI: if you experience problems, try using option 'pci=3Dnoacpi' or =
even 'acpi=3Doff'=0A=
<3>PCI: Cannot allocate resource region 1 of device 0000:00:0a.0=0A=
<3>PCI: Cannot allocate resource region 0 of device 0000:00:02.6=0A=
<3>PCI: Cannot allocate resource region 0 of device 0000:00:0b.0=0A=
<3>PCI: Cannot allocate resource region 1 of device 0000:00:0b.0=0A=
<6>vesafb: framebuffer at 0xf0000000, mapped to 0xde809000, size 16384k=0A=
<6>vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D4=0A=
<6>vesafb: protected mode interface info at cb45:0000=0A=
<6>vesafb: scrolling: redraw=0A=
<6>vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0=0A=
<6>fb0: VESA VGA frame buffer device=0A=
<4>Console: switching to colour frame buffer device 128x48=0A=
<4>pty: 256 Unix98 ptys configured=0A=
<6>Machine check exception polling timer started.=0A=
<6>cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available=0A=
<6>ikconfig 0.5 with /proc/ikconfig=0A=
<6>Initializing Cryptographic API=0A=
<6>ACPI: AC Adapter [ADP0] (on-line)=0A=
<6>ACPI: Battery Slot [BAT0] (battery present)=0A=
<6>ACPI: Power Button (CM) [PWRB]=0A=
<6>ACPI: Sleep Button (CM) [SLPB]=0A=
<6>ACPI: Lid Switch [LID]=0A=
<6>ACPI: Processor [CPU0] (supports C1, 8 throttling states)=0A=
<6>ACPI: Thermal Zone [THM0] (52 C)=0A=
<6>Linux agpgart interface v0.100 (c) Dave Jones=0A=
<6>agpgart: Detected SiS 650 chipset=0A=
<6>agpgart: Maximum main memory to use for agp memory: 410M=0A=
<6>agpgart: AGP aperture is 64M @ 0xe8000000=0A=
<6>[drm] Initialized sis 1.0.0 20010503 on minor 0=0A=
<7>pnp: the driver 'parport_pc' has been registered=0A=
<6>parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]=0A=
<6>parport0: irq 7 detected=0A=
<4>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize=0A=
<6>loop: loaded (max 8 devices)=0A=
<6>8139too Fast Ethernet driver 0.9.26=0A=
<7>PCI: Setting latency timer of device 0000:00:0a.0 to 64=0A=
<6>eth0: RealTek RTL8139 Fast Ethernet at 0xdf820000, 00:90:f5:01:45:45, =
IRQ 11=0A=
<7>eth0:  Identified 8139 chip type 'RTL-8139C'=0A=
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
<6>SIS5513: IDE controller at PCI slot 0000:00:02.5=0A=
<6>SIS5513: chipset revision 208=0A=
<6>SIS5513: not 100%% native mode: will probe irqs later=0A=
<6>SIS5513: SiS 961 MuTIOL IDE UDMA100 controller=0A=
<6>    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio=0A=
<6>    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio=0A=
<4>hda: TOSHIBA MK3018GAP, ATA DISK drive=0A=
<4>Using anticipatory scheduling elevator=0A=
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
<4>hdc: SAMSUNG CD-ROM SN-124, ATAPI CD/DVD-ROM drive=0A=
<4>ide1 at 0x170-0x177,0x376 on irq 15=0A=
<4>hda: max request size: 128KiB=0A=
<6>hda: 58605120 sectors (30005 MB), CHS=3D58140/16/63, UDMA(100)=0A=
<6> hda: hda1 hda2 < hda5 hda6 > hda3=0A=
<4>hdc: ATAPI 24X CD-ROM drive, 128kB Cache=0A=
<6>Uniform CD-ROM driver Revision: 3.12=0A=
<4>Console: switching to colour frame buffer device 128x48=0A=
<4>PCI: Enabling device 0000:00:0c.0 (0000 -> 0002)=0A=
<6>Yenta: CardBus bridge found at 0000:00:0c.0 [1558:4201]=0A=
<4>Yenta IRQ list 02d8, PCI irq5=0A=
<4>Socket status: 30000006=0A=
<6>mice: PS/2 mouse device common for all mice=0A=
<7>drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]=0A=
<7>drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]=0A=
<7>drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [1]=0A=
<7>drivers/input/serio/i8042.c: d3 -> i8042 (command) [4]=0A=
<7>drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [4]=0A=
<7>drivers/input/serio/i8042.c: 0f <- i8042 (return) [4]=0A=
<7>drivers/input/serio/i8042.c: d3 -> i8042 (command) [7]=0A=
<7>drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [7]=0A=
<7>drivers/input/serio/i8042.c: a9 <- i8042 (return) [7]=0A=
<7>drivers/input/serio/i8042.c: d3 -> i8042 (command) [9]=0A=
<7>drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [9]=0A=
<7>drivers/input/serio/i8042.c: ee <- i8042 (return) [9]=0A=
<6>i8042.c: Detected active multiplexing controller, rev 1.1.=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [16]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [16]=0A=
<7>drivers/input/serio/i8042.c: 90 -> i8042 (command) [18]=0A=
<7>drivers/input/serio/i8042.c: a8 -> i8042 (command) [20]=0A=
<7>drivers/input/serio/i8042.c: 91 -> i8042 (command) [21]=0A=
<7>drivers/input/serio/i8042.c: a8 -> i8042 (command) [22]=0A=
<7>drivers/input/serio/i8042.c: 92 -> i8042 (command) [24]=0A=
<7>drivers/input/serio/i8042.c: a8 -> i8042 (command) [25]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [26]=0A=
<7>drivers/input/serio/i8042.c: a8 -> i8042 (command) [27]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [29]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [29]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [31]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [31]=0A=
<7>drivers/input/serio/i8042.c: 90 -> i8042 (command) [34]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [34]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, =
timeout) [57]=0A=
<7>drivers/input/serio/i8042.c: 90 -> i8042 (command) [57]=0A=
<7>drivers/input/serio/i8042.c: ed -> i8042 (parameter) [57]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, =
timeout) [81]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [81]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [81]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [83]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [83]=0A=
<7>drivers/input/serio/i8042.c: 90 -> i8042 (command) [86]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [86]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux0, 12, =
timeout) [109]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [109]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [109]=0A=
<6>serio: i8042 AUX0 port at 0x60,0x64 irq 12=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [114]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [114]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [117]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [117]=0A=
<7>drivers/input/serio/i8042.c: 91 -> i8042 (command) [119]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [119]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux1, 12, =
timeout) [143]=0A=
<7>drivers/input/serio/i8042.c: 91 -> i8042 (command) [143]=0A=
<7>drivers/input/serio/i8042.c: ed -> i8042 (parameter) [143]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux1, 12, =
timeout) [166]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [166]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [166]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [169]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [169]=0A=
<7>drivers/input/serio/i8042.c: 91 -> i8042 (command) [171]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [171]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux1, 12, =
timeout) [195]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [195]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [195]=0A=
<6>serio: i8042 AUX1 port at 0x60,0x64 irq 12=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [200]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [200]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [202]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [202]=0A=
<7>drivers/input/serio/i8042.c: 92 -> i8042 (command) [205]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [205]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 12, =
timeout) [228]=0A=
<7>drivers/input/serio/i8042.c: 92 -> i8042 (command) [228]=0A=
<7>drivers/input/serio/i8042.c: ed -> i8042 (parameter) [228]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 12, =
timeout) [251]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [251]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [251]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [254]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [254]=0A=
<7>drivers/input/serio/i8042.c: 92 -> i8042 (command) [256]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [256]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux2, 12, =
timeout) [280]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [280]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [280]=0A=
<6>serio: i8042 AUX2 port at 0x60,0x64 irq 12=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [285]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [285]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [287]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [287]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [290]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [290]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, bad =
parity, timeout) [295]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [295]=0A=
<7>drivers/input/serio/i8042.c: ed -> i8042 (parameter) [295]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, bad =
parity, timeout) [298]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [298]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [298]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (flush, aux) [300]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [300]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (parameter) [300]=0A=
<7>drivers/input/serio/i8042.c: 93 -> i8042 (command) [303]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [303]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, bad =
parity, timeout) [308]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [308]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [308]=0A=
<7>drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, bad =
parity, timeout) [311]=0A=
<6>serio: i8042 AUX3 port at 0x60,0x64 irq 12=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [315]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [315]=0A=
<7>drivers/input/serio/i8042.c: 60 -> i8042 (command) [317]=0A=
<7>drivers/input/serio/i8042.c: 01 -> i8042 (parameter) [317]=0A=
<7>drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [320]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [324]=0A=
<7>drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [325]=0A=
<7>drivers/input/serio/i8042.c: 83 <- i8042 (interrupt, kbd, 1) [329]=0A=
<7>drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [329]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [333]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [333]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [337]=0A=
<7>drivers/input/serio/i8042.c: f8 -> i8042 (kbd-data) [337]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [342]=0A=
<7>drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [342]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [346]=0A=
<7>drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [346]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [350]=0A=
<7>drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [350]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [355]=0A=
<7>drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [355]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [359]=0A=
<7>drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [359]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [364]=0A=
<7>drivers/input/serio/i8042.c: 02 <- i8042 (interrupt, kbd, 1) [366]=0A=
<6>input: AT Set 2 keyboard on isa0060/serio0=0A=
<6>serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
<6>NET4: Linux TCP/IP 1.0 for NET4.0=0A=
<6>IP: routing cache hash table of 4096 buckets, 32Kbytes=0A=
<6>TCP: Hash tables configured (established 32768 bind 65536)=0A=
<6>IPv4 over IPv4 tunneling driver=0A=
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
<6>cpufreq: No CPUs supporting ACPI performance management found.=0A=
<6>ACPI: (supports S0 S3 S4 S5)=0A=
<5>RAMDISK: Compressed image found at block 0=0A=
<6>Freeing initrd memory: 348k freed=0A=
<4>VFS: Mounted root (ext2 filesystem).=0A=
<4>found reiserfs format "3.6" with standard journal=0A=
<4>Reiserfs journal params: device hda1, size 8192, journal first block =
18, max trans len 1024, max batch 900, max commit age 30, max trans age =
30=0A=
<4>reiserfs: checking transaction log (hda1) for (hda1)=0A=
<4>Using r5 hash to sort names=0A=
<4>VFS: Mounted root (reiserfs filesystem) readonly.=0A=
<5>Trying to move old root to /initrd ... failed=0A=
<5>Unmounting old root=0A=
<5>Trying to free ramdisk memory ... okay=0A=
<6>Freeing unused kernel memory: 172k freed=0A=
<6>Adding 514040k swap on /dev/hda6.  Priority:42 extents:1=0A=
<6>NTFS driver 2.1.4 [Flags: R/O MODULE].=0A=
<6>NTFS volume version 3.1.=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [9138]=0A=
<7>drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [10141]=0A=
<7>drivers/input/serio/i8042.c: 5a <- i8042 (interrupt, kbd, 1) [13488]=0A=
<7>drivers/input/serio/i8042.c: f0 <- i8042 (interrupt, kbd, 1) [13559]=0A=
<7>drivers/input/serio/i8042.c: 5a <- i8042 (interrupt, kbd, 1) [13564]=0A=
<4>blk: queue ddd79e00, I/O limit 4095Mb (mask 0xffffffff)=0A=
<4>hdc: Disabling (U)DMA for SAMSUNG CD-ROM SN-124=0A=
Kernel logging (ksyslog) stopped.=0A=
Kernel log daemon terminating.=0A=
=0A=
Boot logging started on /dev/tty1(/dev/console) at Fri Aug 15 16:09:59 =
2003=0A=
=0A=
modprobe: FATAL: Module block_major_9 not found.=0A=
=0A=
=0A=
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel=0A=
Run file system check on root for LVM activation=0A=
doneRemounting root file system (/) read/write for vgscan...=0A=
Scanning for LVM volume groups...=0A=
modprobe: FATAL: Module char_major_109 not found.=0A=
=0A=
=0A=
vgscan -- LVM driver/module not loaded?=0A=
=0A=
Activating LVM volume groups...=0A=
modprobe: FATAL: Module char_major_109 not found.=0A=
=0A=
=0A=
modprobe: FATAL: Module char_major_109 not found.=0A=
=0A=
=0A=
vgchange -- LVM driver/module not loaded?=0A=
=0A=
done=0A=
Activating swap-devices in /etc/fstab...=0A=
doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel=0A=
Checking file systems...=0A=
fsck 1.28 (31-Aug-2002)=0A=
Reiserfs super block in block 16 on 0x301 of format 3.6 with standard =
journal=0A=
Blocks (total/free): 1536207/4138 by 4096 bytes=0A=
Filesystem is clean=0A=
doneMounting local file systems...=0A=
proc on /proc type proc (rw)=0A=
devpts on /dev/pts type devpts (rw,mode=3D0620,gid=3D5)=0A=
/sys on /sys type sysfs (rw)=0A=
/dev/hda3 on /windows type ntfs =
(ro,nosuid,nodev,nls=3Diso8859-2,umask=3D000)=0A=
doneActivating crypto devices using /etc/cryptotab ... =0A=
FATAL: Module loop_fish2 not found.=0A=
Please enter passphrase for /dev/hda5. failedLoading required kernel =
modules=0A=
doneSetting up IDE DMA mode=0A=
=0A=
/dev/hda:=0A=
 setting using_dma to 1 (on)=0A=
 using_dma    =3D  1 (on)=0A=
=0A=
/dev/hdc:=0A=
 setting using_dma to 1 (on)=0A=
 using_dma    =3D  1 (on)=0A=
done=0A=
Restore device permissionsdone=0A=
Activating remaining swap-devices in /etc/fstab...=0A=
doneSetting up the CMOS clockmodprobe: FATAL: Module char_major_10_135 =
not found.=0A=
=0A=
=0A=
modprobe: FATAL: Module char_major_10_135 not found.=0A=
=0A=
=0A=
done=0A=
Setting up timezone datadone=0A=
Setting up hostname 'izidor'done=0A=
Setting up loopback interface done=0A=
Disabling IP forwardingdone=0A=
Creating /var/log/boot.msg=0A=
doneshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel=0A=
<notice>killproc: kill(30,29)=0A=
Running /etc/init.d/boot.local=0A=
=0A=
/dev/hda:=0A=
 setting 32-bit IO_support flag to 1=0A=
 setting unmaskirq to 1 (on)=0A=
 setting standby to 60 (5 minutes)=0A=
 IO_support   =3D  1 (32-bit)=0A=
 unmaskirq    =3D  1 (on)=0A=
/etc/init.d/boot.local: line 16: /proc/sys/dev/rtc/max-user-freq: No =
such file or directory=0A=
failed<notice>killproc: kill(30,3)=0A=
=0A=

------=_NextPart_000_00CD_01C36338.0D607710--

