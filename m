Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272701AbRHaOU3>; Fri, 31 Aug 2001 10:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272704AbRHaOUU>; Fri, 31 Aug 2001 10:20:20 -0400
Received: from ns1.hicom.net ([208.245.180.8]:20485 "EHLO ns1.hicom.net")
	by vger.kernel.org with ESMTP id <S272701AbRHaOUI>;
	Fri, 31 Aug 2001 10:20:08 -0400
From: "Stephen von Voros" <stevon@hicom.net>
To: <linux-kernel@vger.kernel.org>
Subject: fix pppd daemon
Date: Fri, 31 Aug 2001 10:34:59 -0400
Message-ID: <MLEPIMPCNOKIBHIBMPMFMEKKCAAA.stevon@hicom.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Stephen von Voros [mailto:stevon@hicom.net]
Sent: Friday, August 31, 2001 10:31 AM
To: linux-kernel@vger.kernel.org
Subject: fix pppd daemon


Diald killed pppd
I recently installed diald 0.99.4. into RH 7.1 2.4.3-12. After diald
is started it listens for http requests and initializes pppd with
the chat program and connect script. The problem is that since the
first time I ran diald, pppd no longer works with any command or
dialup tool. It worked fine before with no problems. Using RedHats
"Dialup configuration tool" I highlighted the ppp0 interface and
clicked on the debug button. After it finished I was asked to create
& save a log file. I named it "ppp.log" this was what it looks like:

WvDial: Internet dialer version 1.41
Initializing modem
Sending ATZ
ATZ
OK
Sending: ATQ0 V1 E1 S0=0 &D2 S11=55 +FCLASS=0
ATQ0 V1 E1 S0=0 &D2 S11=55 +FCLASS=0
OK
Modem initialized
Sending ATDT9733058585
Waiting for carrier
ATDT 9733058585
CONNECT 115200
Carrier detected. waiting for prompt

Welcome to HICom Internet Access, tc1 15-10

login: Looks like a login prompt.
Sending:(stevon)
stevon
login: Looks like a password prompt.
Sending:(password)

~}#@!}!}!} }?}!}$}% -|~PPP negotiation detected.
Starting pppd at Thu Aug 30 18:00:48 2001
PPP daemon has died! (exit code=10)
Disconnecting at Thu Aug 30 18:01:22 2001
Auto reconnect will be attempted in 5 seconds
pppd error! look for an explanation in /var/log/messages.

Initializing modem
Sending ATZ
(I stoped here)

SvV- something is wrong with pppd, I wonder what error (exit code=10)
means?

Checking the /var/log/messages I looked at entries related to ppp:

Aug 30 18:00:48 stevon kernel PPP generic driver version 2.4.1
Aug 30 18:00:48 stevon pppd [954]: 2.4.0 started by root, uid 0
Aug 30 18:00:48 stevon pppd [954]: Using interface ppp0
Aug 30 18:00:48 stevon pppd [954]: Connect: ppp0 <--> /dev/ttyS3
Aug 30 18:00:49 stevon su(pam_unix)[975] session opened for user root by
(uid=0)
Aug 30 18:00:49 stevon su(pam_unix)[975] session closed for user root
Aug 30 18:00:49 stevon su(pam_unix)[980] session opened for user root by
(uid=0)
Aug 30 18:00:49 stevon su(pam_unix)[980] session closed for user root
Aug 30 18:00:51 stevon kernel PPP Deflate Compression module registered
Aug 30 18:00:52 stevon pppd [954]: Recieved bad configure -nak/rej: 03 06 d0
f5 b6 70
Aug 30 18:01:22 stevon pppd [954]: IPCP: timeout sending config-request
Aug 30 18:01:22 stevon pppd [954]: Connection terminated
Aug 30 18:01:22 stevon pppd [954]: Exit

The previous day entries shows that pppd worked and interface ppp0 was
started
and running. How do I fix the pppd daemon?

Stephen von Voros
please personally CC the answers/comments to stevon@hicom.net

