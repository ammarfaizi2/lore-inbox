Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRABQC6>; Tue, 2 Jan 2001 11:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbRABQCt>; Tue, 2 Jan 2001 11:02:49 -0500
Received: from latt.if.usp.br ([143.107.129.103]:13576 "HELO latt.if.usp.br")
	by vger.kernel.org with SMTP id <S129436AbRABQCe>;
	Tue, 2 Jan 2001 11:02:34 -0500
Date: Tue, 2 Jan 2001 13:32:06 -0200 (BRST)
From: "Jorge L. deLyra" <delyra@latt.if.usp.br>
To: linux-kernel@vger.kernel.org
Subject: NFS root doesn't work with 2.2.18.
Message-ID: <Pine.LNX.3.96.1010102131929.12860H-100000@latt.if.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had a K7 booting kernel 2.2.17 OK and mounting an NFS root but that
doesn't work anymore if I use the 2.2.18 kernel.

Both kernels were compiled with the same configs. I'm also using the same
lilo and NBI configs, both used to work. In either case the new kernel
boots but can't mount the root. I can't boot 2.2.18 via NBI because I
don't see any messages, looks like the serial driver never comes in.

I send below the relevant parts of the boot messages for the 2.2.17 and
2.2.18 kernels. Looks like 2.2.18 never gets to the point of trying to
raise the network and panics because it can't find its root. Is this a
known problem? Is there a known fix?
							Regards,

----------------------------------------------------------------
        Jorge L. deLyra,  Associate Professor of Physics
            The University of Sao Paulo,  IFUSP-DFMA
       For more information: finger delyra@latt.if.usp.br
----------------------------------------------------------------

Boot messages with kernel 2.2.17:

(lilo or nbi, kernel loads, etc, everything OK up to here)
...
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
3c59x.c 16Aug00 Donald Becker and others
				http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905B Cyclone 100baseTx at 0xec00,  00:01:02:77:4f:f7, IRQ 15
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  MII transceiver found at address 0, status 786d.
  Enabling bus-master transmits and whole-frame receives.
IP-Config: Complete:
      device=eth0, addr=192.168.0.10, mask=255.255.0.0, gw=192.168.0.1,
     host=n0000, domain=, nis-domain=(none),
     bootserver=192.168.0.1, rootserver=192.168.0.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.0.1
Looking up port of RPC 100005/1 on 192.168.0.1
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 40k freed
INIT: version 2.78 booting
...
(goes on to boot normally)

Boot messages with kernel 2.2.17:

(lilo, kernel loads, etc, everything OK up to here)
...
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
scsi : 0 hosts.
scsi : detected total.
VFS: Cannot open root device 00:00
Kernel panic: VFS: Unable to mount root fs on 00:00


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
