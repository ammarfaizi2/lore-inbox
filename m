Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTJKToT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTJKToT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:44:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:60319 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263385AbTJKToE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:44:04 -0400
Date: Sat, 11 Oct 2003 21:44:03 +0200 (MEST)
From: "Howard Duck" <h.t.d@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: observation: sata problems when using devfs with 2.6.0beta7
X-Priority: 3 (Normal)
X-Authenticated: #295886
Message-ID: <25707.1065901443@www55.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
 
I understand that devfs is deprecated, and i personally don't need (or
suggest) 
this issue to be fixed - but there are maybe some people that run into this 
problem too, and they may profit from this information... Now here's the
story: I 
have a intel 865pe based mainboard with 4 pata devices and one sata disk
(the 
one i boot off). Gentoo linux "needs" devfs support therefore i added it to
my 
kernel config. When i booted i got following warning/debug messages: 
 
irq: 18 nobody cared! 
*some hex output i was too lazy to write down* 
Disabling IRQ #18 
 
IRQ 18 is assigned to the SATA controller (there are also a few lkml posts
that 
describe this error). At first i thought it was some problem with sata - to
verify this 
i started to test with a almost featureless kernel and added one feature
after 
another to see what breaks the system. The irq18 problem only appeared when
i 
added devfs support to the kernel. I have no real proof that devfs support
affects 
the sata controller/disk, but i built many different kernel configs and
whenever i 
added devfs support the irq18 warnings appeared, and whenever i removed
devfs 
support they did not appear - so i guess devfs is the actual problem. 
 
I currently run gentoo-linux with a SMP enabled 2.6.0beta7 kernel with alsa
and 
the nvidia-drivers but without devfs support. Everything works fine for me,
seems 
like devfs support isn't that badly needed for gentoo ;) to turn off support
for it 
simply add gentoo=nodevfs to your kernel boot-parameters. Creating the /dev 
entries for alsa can be done with the snddevices script provided by the
alsa-driver 
source package. I didn't need any other /dev nodes, because i don't have USB

peripherals and the likes... 
 
now on to the gentoo-developers persuading them to drop the devfs dependency

;) 
 Michael Kefeder 
 
p.s.: i'm not subscribed to lkml - please put me on CC when answering. 
 

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

