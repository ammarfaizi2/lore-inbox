Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318856AbSHWPIR>; Fri, 23 Aug 2002 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSHWPIR>; Fri, 23 Aug 2002 11:08:17 -0400
Received: from string.physics.ubc.ca ([142.103.234.11]:47273 "HELO
	string.physics.ubc.ca") by vger.kernel.org with SMTP
	id <S318853AbSHWPIO>; Fri, 23 Aug 2002 11:08:14 -0400
Date: Fri, 23 Aug 2002 08:12:24 -0700 (PDT)
From: Bill Unruh <unruh@physics.ubc.ca>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: <linux-ppp@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.33.0208231029040.8320-100000@router.windsormachine.com>
Message-ID: <Pine.LNX.4.33L2.0208230806050.16223-100000@string.physics.ubc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it would be good if you actually told us what problem you were
describing. Is this a new connection attempt after the first hang up?
What?

What repeats over and over-- I see no repeat.

You also do not tell us info like what kind of modem is this-- external,
internal, serial, usb, pci, winmodem,....

I assume what you are refering to is the "inappropriate ioctl" line.
This indicates a hardware problem.

Actually, it looks to me like another pppd is up on the line. Those
EchoReq are another pppd receiving stuff on an open pppd on another
line. More information on what it is you are trying to do, on what your
system is, and what the problem is might get you help.


On Fri, 23 Aug 2002, Mike Dresser wrote:

> I'm having problems with pppd under 2.4.19, with pppd 2.4.1
>
> I can establish a new connection, and no problems.  But once the ISP on
> the other end hangs up, this is what i get in my syslog.
> Repeats over and over.  I saw a few google postings about this, but those
> were back in _1999_, so I would think they were fixed by now.
>
> Doesn't matter if PPP is compiled in with the kernel, or modules.
>
> I'm running Debian 3.0(woody)
>
> This worked under Debian 2.2 and kernel 2.2.21
>
> Aug 23 10:25:55 tilburybackup chat[9825]: abort on (BUSY)
> Aug 23 10:25:55 tilburybackup chat[9825]: abort on (NO CARRIER)
> Aug 23 10:25:55 tilburybackup chat[9825]: abort on (VOICE)
> Aug 23 10:25:55 tilburybackup chat[9825]: abort on (NO DIALTONE)
> Aug 23 10:25:55 tilburybackup chat[9825]: abort on (NO DIAL TONE)
> Aug 23 10:25:55 tilburybackup chat[9825]: abort on (NO ANSWER)
> Aug 23 10:25:55 tilburybackup chat[9825]: send (ATZ^M)
> Aug 23 10:25:55 tilburybackup chat[9825]: expect (OK)
> Aug 23 10:25:55 tilburybackup chat[9825]: ATZ^M^M
> Aug 23 10:25:55 tilburybackup chat[9825]: OK
> Aug 23 10:25:55 tilburybackup chat[9825]:  -- got it
> Aug 23 10:25:55 tilburybackup chat[9825]: send (ATDT3806600^M)
> Aug 23 10:25:55 tilburybackup chat[9825]: expect (CONNECT)
> Aug 23 10:25:55 tilburybackup chat[9825]: ^M
> Aug 23 10:26:11 tilburybackup pppd[9804]: rcvd [LCP EchoReq id=0x4 magic=0x96835d5b]
> Aug 23 10:26:11 tilburybackup pppd[9804]: sent [LCP EchoRep id=0x4 magic=0x72c56787]
> Aug 23 10:26:11 tilburybackup pppd[9804]: sent [LCP EchoReq id=0x4 magic=0x72c56787]
> Aug 23 10:26:11 tilburybackup pppd[9804]: rcvd [LCP EchoRep id=0x4 magic=0x96835d5b]
> Aug 23 10:26:16 tilburybackup chat[9825]: ATDT3806600^M^M
> Aug 23 10:26:16 tilburybackup chat[9825]: CONNECT
> Aug 23 10:26:16 tilburybackup chat[9825]:  -- got it
> Aug 23 10:26:16 tilburybackup chat[9825]: send (\d)
> Aug 23 10:26:17 tilburybackup pppd[329]: Serial connection established.
> Aug 23 10:26:17 tilburybackup pppd[329]: using channel 1179
> Aug 23 10:26:17 tilburybackup pppd[329]: Couldn't create new ppp unit: Inappropriate ioctl for device
> Aug 23 10:26:18 tilburybackup pppd[329]: Hangup (SIGHUP)
>
> tilburybackup:/etc/ppp# egrep -v '#|^ *$' /etc/ppp/options
> asyncmap 0
> auth
> crtscts
> lock
> hide-password
> modem
> proxyarp
> lcp-echo-interval 30
> lcp-echo-failure 4
> noipx
> persist
> maxfail 0
>
> ttyS04 at port 0xcc00 (irq = 5) is a 16550A
>
> 00:0b.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
>         Subsystem: US Robotics/3Com USR 56k Internal FAX Modem (Model 2977)
>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 5
>         Region 0: I/O ports at cc00 [size=8]
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>
> Any ideas?
>
> Mike
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ppp" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
William G. Unruh        Canadian Institute for          Tel: +1(604)822-3273
Physics&Astronomy          Advanced Research            Fax: +1(604)822-5324
UBC, Vancouver,BC        Program in Cosmology           unruh@physics.ubc.ca
Canada V6T 1Z1               and Gravity           www.theory.physics.ubc.ca/
For step by step instructions about setting up ppp under Linux, see
            http://www.theory.physics.ubc.ca/ppp-linux.html

