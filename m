Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318850AbSHWOk5>; Fri, 23 Aug 2002 10:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318848AbSHWOk4>; Fri, 23 Aug 2002 10:40:56 -0400
Received: from windsormachine.com ([206.48.122.28]:19208 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S318846AbSHWOky>; Fri, 23 Aug 2002 10:40:54 -0400
Date: Fri, 23 Aug 2002 10:45:02 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-ppp@vger.kernel.org>
cc: <linux-kernel@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0208231029040.8320-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with pppd under 2.4.19, with pppd 2.4.1

I can establish a new connection, and no problems.  But once the ISP on
the other end hangs up, this is what i get in my syslog.
Repeats over and over.  I saw a few google postings about this, but those
were back in _1999_, so I would think they were fixed by now.

Doesn't matter if PPP is compiled in with the kernel, or modules.

I'm running Debian 3.0(woody)

This worked under Debian 2.2 and kernel 2.2.21

Aug 23 10:25:55 tilburybackup chat[9825]: abort on (BUSY)
Aug 23 10:25:55 tilburybackup chat[9825]: abort on (NO CARRIER)
Aug 23 10:25:55 tilburybackup chat[9825]: abort on (VOICE)
Aug 23 10:25:55 tilburybackup chat[9825]: abort on (NO DIALTONE)
Aug 23 10:25:55 tilburybackup chat[9825]: abort on (NO DIAL TONE)
Aug 23 10:25:55 tilburybackup chat[9825]: abort on (NO ANSWER)
Aug 23 10:25:55 tilburybackup chat[9825]: send (ATZ^M)
Aug 23 10:25:55 tilburybackup chat[9825]: expect (OK)
Aug 23 10:25:55 tilburybackup chat[9825]: ATZ^M^M
Aug 23 10:25:55 tilburybackup chat[9825]: OK
Aug 23 10:25:55 tilburybackup chat[9825]:  -- got it
Aug 23 10:25:55 tilburybackup chat[9825]: send (ATDT3806600^M)
Aug 23 10:25:55 tilburybackup chat[9825]: expect (CONNECT)
Aug 23 10:25:55 tilburybackup chat[9825]: ^M
Aug 23 10:26:11 tilburybackup pppd[9804]: rcvd [LCP EchoReq id=0x4 magic=0x96835d5b]
Aug 23 10:26:11 tilburybackup pppd[9804]: sent [LCP EchoRep id=0x4 magic=0x72c56787]
Aug 23 10:26:11 tilburybackup pppd[9804]: sent [LCP EchoReq id=0x4 magic=0x72c56787]
Aug 23 10:26:11 tilburybackup pppd[9804]: rcvd [LCP EchoRep id=0x4 magic=0x96835d5b]
Aug 23 10:26:16 tilburybackup chat[9825]: ATDT3806600^M^M
Aug 23 10:26:16 tilburybackup chat[9825]: CONNECT
Aug 23 10:26:16 tilburybackup chat[9825]:  -- got it
Aug 23 10:26:16 tilburybackup chat[9825]: send (\d)
Aug 23 10:26:17 tilburybackup pppd[329]: Serial connection established.
Aug 23 10:26:17 tilburybackup pppd[329]: using channel 1179
Aug 23 10:26:17 tilburybackup pppd[329]: Couldn't create new ppp unit: Inappropriate ioctl for device
Aug 23 10:26:18 tilburybackup pppd[329]: Hangup (SIGHUP)

tilburybackup:/etc/ppp# egrep -v '#|^ *$' /etc/ppp/options
asyncmap 0
auth
crtscts
lock
hide-password
modem
proxyarp
lcp-echo-interval 30
lcp-echo-failure 4
noipx
persist
maxfail 0

ttyS04 at port 0xcc00 (irq = 5) is a 16550A

00:0b.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
        Subsystem: US Robotics/3Com USR 56k Internal FAX Modem (Model 2977)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at cc00 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Any ideas?

Mike

