Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTJIVGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJIVGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:06:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:17041 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262581AbTJIVGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:06:06 -0400
Date: Thu, 9 Oct 2003 23:06:05 +0200 (MEST)
From: "Howard Duck" <h.t.d@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: kernel 2.6.0betaX: ich5 sata enhanced mode hangs during init
X-Priority: 3 (Normal)
X-Authenticated: #295886
Message-ID: <22605.1065733565@www40.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
 
I have a Mainboard with a intel 865PE chipset. I tested many kernels to get
my 
Serial-ATA (sata) disk to work in enhanced mode and so far only one kernel 
works - 2.5.74. I need the enhanced mode because I lose all secondary ide 
ports if i switch to legacy/compatible mode in the mainboards bios (which 
disables some of my drives). 
 
Since the first beta of kernel 2.6.0 i had no luck in successfully booting
the 
machine unless i switched to SATA legacy mode. All 2.6.0beta-kernels make it

to the init sequence and detect the sata disk, but the system hangs at
random 
postions during init (starting devfsd, mounting swap or setting the machines

hostname, well - somewhere during startup). 
 
I tried removing swap from /etc/fstab and disabling some init-scripts but it

doesn't help. Booting in "single" mode does not work too. The only thing
that 
works is using legacy sata support, so i guess it is related to some new
code for 
handling serial ata controllers/disks (the machine boots off a sata disk) in
the 
2.6.0beta kernels. 2.5.74 boots and works w/o problems, but i'd feel better
if i 
run a kernel marked "stable" ;) 
 
Is there something i can do to trace the problem of the hang during boot,
maybe 
some special kernel options, new user-space tools,...? Is this maybe related
to 
SMP support or hyperthreading cpus? 
 
I am open for any hints or test-procedures that may help to fix or find the 
problem. 
thanks in advance 
 Michael Kefeder 
 
p.s.: i'm not subscribed to the lkml, please put me on CC when answering 
 

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

