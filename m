Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSLBQOa>; Mon, 2 Dec 2002 11:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSLBQOa>; Mon, 2 Dec 2002 11:14:30 -0500
Received: from mail.wincom.net ([209.216.129.3]:44306 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S264630AbSLBQO3>;
	Mon, 2 Dec 2002 11:14:29 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Mon, 02 Dec 2002 11:22:29 -0500
Subject: [MAY-BE-OT] Slow FTP Transfers between 2.4 machines
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3deb8890.779c.0@wincom.net>
X-User-Info: 129.9.26.50
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This _might_ be OT... certainly I'm not entirely ready to lay this at the feet
of the kernel just yet. Any pointers to troubleshooting documents would be _greatly_
appreciated.

Box 1: P1-233 Vanilla 2.4.19. Generic PCI ne2000 card based on a RealTek 8029(?
- can confirm later)

Box 2: Athlon 2100+ Vanilla 2.4.20rc4 + Broadcom-provided driver module. Asus
A7V8X w/onboard Broadcom 10/100 

Boxes are connected with 10BaseT and a NetGear 10Mbs 4-port hub. Hub is further
connected to a Samsung cable modem.

FTP from either box to a decent server via the cable modem may go as high as
250-ish k/sec. FTP transfers from box to box start out at ~ 100k/sec and very
quickly (3sec) drop to a stable 42 k/sec which persists for the rest of the
transfer, independant of which box is server or client.

Both boxes are using vsftpd behind xinetd, vsftpd manual was RTFMed and I'm
pretty sure this isn't a userspace-daemon-throttling thing (although some form
of verification that this is the case would be nice)

Diagnostics located from a link in the Ethernet-HOWTO show both cards in a 10Mbs,
half-duplex state with no reported errors.

ifconfig/proc reports show no collisions or other errors to speak of. CPU remains
near-idle on both boxes during transfers. The TX/RX lights on the hub are "leisurely"
- the transfers don't look like a constrant stream, but rather more like regular
bursts of activity. 

I can find no evidence of errors or of anything wrong anywhere, aside from the
transfers being slow, and that telnet sessions from one box to the other get
choppy and laggy during large transfers. Once the transfer is completed, responsiveness
returns to normal.

Pointers to trobleshooting documents would be greatly appreciated. I have had
little luck finding anything on my own.

DG



