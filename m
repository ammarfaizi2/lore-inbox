Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUC3FwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbUC3FwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:52:16 -0500
Received: from smtp1.fuse.net ([216.68.8.171]:46232 "EHLO smtp1.fuse.net")
	by vger.kernel.org with ESMTP id S263226AbUC3FwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:52:07 -0500
From: "Ivica Ico Bukvic" <ico@fuse.net>
To: "'A list for linux audio users'" 
	<linux-audio-user@music.columbia.edu>,
       <alsa-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <linux-pcmcia@lists.infradead.org>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus=distortion -- the sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it is the cardbus driver yenta_socket
Date: Tue, 30 Mar 2004 00:52:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-index: AcQV0TXomEbe4s2EQVeW6vMmbNh1mgARfHPA
In-Reply-To: <20040329235823.04bacef4@laptop>
Message-Id: <20040330055204.UUGL2042.smtp1.fuse.net@64BitBadass>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the update on the issue (at least from my aspect):

TODO:
1) provide detailed lspci
(will do later tomorrow, too tired right now)

2) thoroughly check /var/log/syslog for anything suspicious
Apart from the ACPI and APIC problems, nothing out of the ordinary (i.e.
APIC assigns IRQ 0 to cardbus and therefore nothing works, but if I disable
APIC it's all ok. Furthermore, I've just yesterday fixed the ACPI and APIC
problems by patching the kernel yet the problem persists. Right now the
laptop boots with ACPI and APIC turned on, IRQ's get assigned properly, as a
matter of fact EXACTLY the same like in Windows where the problem does not
occur. Therefore, now the assumption that there is a "sweet" IRQ I need to
select does not stand any more, as the same problem is exhibiting itself
when the cardbus is at IRQ 11 (no ACPI/APIC) or at 17 (with ACPI/APIC and
also the same IRQ as in WinXP). This now leads me to believe that the
problem is strictly limited to the yenta_socket driver.

3) try pcmcia-cs (most likely won't work as Tim already tried that and it
made no difference on his laptop, also the package wasn't updated since
Dec.)

This is not an option, as Tim pointed out, not only because this package
only works with pre 2.5 kernels but also because it has been tested by Tim
and had no difference.

4) try playback with an external Word Clock source
Will try tomorrow (although I don't think so, as the card appears to work
just fine on other Linux notebook).

5) provide downloadable examples of the distorted sounds
(will do tomorrow). But by briefly looking at it, it definitely looks the
same like Tim's (image found here:
http://www.volny.cz/guitar_billy/hdsp.screenshot.png) where it seems like
the sound has one small burst of audio data, then the comparably-sized
streak of no change in data. There is still some distortion which I am not
sure whether it is a result of this kind of misperformance of the sound or
there is more to the story.

6) Pester alsa-dev, lau, and kernel/pcmcia people to death begging for help
:-)

IN-PROGRESS :-)

7) Pester eMachines to update BIOS (I may retire before this one happens,
though)

I did get through to someone and they did reply to my e-mail seeming
interested in cooperating to resolve the issue, but at this point it does
not seem like the BIOS is the culprit.


8) Something else?
How about I go catch some z's :-)

Good idea...


Best wishes,

Ico


