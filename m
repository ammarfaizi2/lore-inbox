Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313434AbSDLToy>; Fri, 12 Apr 2002 15:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314140AbSDLTox>; Fri, 12 Apr 2002 15:44:53 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:29403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313434AbSDLTow>;
	Fri, 12 Apr 2002 15:44:52 -0400
X-Flags: 1011
Date: Fri, 12 Apr 2002 21:44:05 +0200
From: Stefan Riha <s.riha@gmx.at>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
In-Reply-To: <14502.1017869163@www1.gmx.net>
Subject: Freecom portable CD-RW writer IO errors
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0001624034@gmx.net
X-Authenticated-IP: [62.47.204.180]
Message-ID: <20274.1018036705@www42.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Modified-Forwards: 2M.inbox
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have asked the question on the parport mailing list on torque.net but 
nobody have an answere for me. One people on the parport list has sayed to 
me, that i should ask my question on the linux kernel mailing list.
Now i hope that you can help me witch this question.

Now my question:

I want to use my Freecom portable CD-RW writer (2x2x24) under Linux.
The writer is with a Freecom parallel port cable connected to my computer.
For testing i have connected the writer on a 486 computer.
Now i have installed RedHat 6.2 and when i want to mount a data CD i get the
following errors.
Now i have Installed Suse 7.2 and i get the same errors when i want to mount
the data CD.

Now an concrete description of what i have done under RedHat 6.2

#lsmod
Module        Size    Used    by
lockd         31912    1      (autoclean)
sunrpc        53604    1      (autoclean) [locked]
rtl8139       12132    1      (autoclean)

#modprobe paride
paride: version 1.04 installed

#modprobe friq
paride: friq registered as protocol 0

#modprobe pcd
pcd: pcd version 1.07, major 46, nice 0
pcd0: Sharing parport0 at 0x378
pcd0: friq 1.01, Freecom IQ ASCI-2 adapter at 0x378, mode 4 (EPP-32), delay
1
pcd0: Master R/RW 2x2x24

#lsmod
Module                  Size  Used by
parport_probe           3272   0  (autoclean)
parport_pc              7400   1  (autoclean)
pcd                    11556   0  (unused)
friq                    8544   1 
paride                  3532   1  [pcd friq]
parport                 7516   1  [parport_probe parport_pc paride]
lockd                  31912   1  (autoclean)
sunrpc                 53604   1  (autoclean) [lockd]
rtl8139                12132   1  (autoclean)

Als nächstes wollte ich eine Daten CD mounten:

#mount /dev/pcd0 /mnt/cdrom
pcd0: WARNING: ATAPI phase errors
pcd0: Stuck DRQ 
pcd0: lock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
pcd0: read block before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
end_request: I/O error, dev 2e:00 (PCD), sector 2 
/dev/pcd0: Eingabe-/Ausgabefehler
pcd0: unlock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
mount: blockorientiertes Gerät /dev/pcd0 ist schreibgeschützt, es wird im
       Nur-Lese-Modus gemountet
pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2  
pcd0: unlock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
pcd0: unlock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001
phase=2 
mount: Kein Medium gefunden

I hope you can help me.

MFG
Stefan Riha

--  To unsubscribe, send mail to: linux-parport-request@torque.net --
--  with the single word "unsubscribe" in the body of the message. --

