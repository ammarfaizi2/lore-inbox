Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263432AbRFNRjR>; Thu, 14 Jun 2001 13:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263434AbRFNRjH>; Thu, 14 Jun 2001 13:39:07 -0400
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:53242 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S263432AbRFNRjB>; Thu, 14 Jun 2001 13:39:01 -0400
Message-ID: <3B28F68C.BA9D83DA@uu.net>
Date: Thu, 14 Jun 2001 13:38:20 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: APM, ACPI, and Wake on LAN - the bane of my existance
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an athlon system with a iwill kk266 motherboard (via kt133A).  I
have a linksys 10/100 PCI ethernet card with wake on lan capabilities. 
Anyway, when I shut the PC down it turns off, but refuses to stay off. 
Within a minute or two, it turns itself on again.  If i run over and
turn it off by hitting the power putton, it turns off, but then comes
back on again at a later somewaht arbitrary time (1 minute to several
hours later).  I originally got the WOL card so I could remotely boot my
PC, but at this point it has turned out to be more trouble than it's
worth.  I tried to disable WOL inthe BIOS, but that didn't change
anything.  So I removed the three pin cross connect that connects the
card to the WOL header on the motherboard.  That fixed it for a few
days, but now it's doing it again, even without the cable installed. 
the only fix is to unplug the ethernet cable when I turn it off.  

I suspect the problem has something to do with WOL vs. resume on LAN. 
the system should only turn on when it recieves a magic packet, but it
seems that any packet may cause it to boot (or resume, but since it is
in the "off" state, boot).  I've only been using APM, but perhaps acpi
is required for this to work properly.  As far as why it does this when
the 3 pin WOL connector was not used, I'm not sure, maybe something to
do with PCI 2.2.

Any thoughts?  This is driving me nuts.

Alex

Please CC: me in your reply.
