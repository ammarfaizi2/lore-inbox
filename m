Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282596AbRK0SyT>; Tue, 27 Nov 2001 13:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282584AbRK0SyA>; Tue, 27 Nov 2001 13:54:00 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:12928 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S282596AbRK0Sx6>; Tue, 27 Nov 2001 13:53:58 -0500
Message-ID: <00f501c17774$dc297260$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Jordan Russell" <jr-list-kernel@quo.to>, <linux-kernel@vger.kernel.org>
In-Reply-To: <002301c1776c$b9776ef0$024d460a@neptune>
Subject: Re: 2.4(.16) kernel logs messages in the wrong order
Date: Tue, 27 Nov 2001 19:53:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Jordan Russell" <jr-list-kernel@quo.to>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 27, 2001 6:55 PM
Subject: 2.4(.16) kernel logs messages in the wrong order


> Hi,
> Here's an excerpt from my /var/log/messages. Notice how messages from two
> different times are strangely mixed together. What's going on? Is there
some
> way to fix it? This does not happen when a 2.2.x kernel is used.
>
> Nov 27 11:38:54 webby sysctl: net.ipv4.conf.default.rp_filter = 1
> Nov 27 11:39:15 webby kernel: NET4: Linux TCP/IP 1.0 for NET4.0
> Nov 27 11:38:54 webby sysctl: kernel.sysrq = 1
> Nov 27 11:39:15 webby kernel: IP Protocols: ICMP, UDP, TCP
> Nov 27 11:38:54 webby sysctl: net.ipv4.ip_forward = 1
> Nov 27 11:39:15 webby kernel: IP: routing cache hash table of 4096
buckets,
> 32Kbytes
> Nov 27 11:38:54 webby rc.sysinit: Configuring kernel parameters:
succeeded
>
> I'm using Red Hat 7.2 if it matters.

Just use "dmesg" instead, that will give you a correct order if you are
looking for bootup messages.

Problem is that /var/log/messages is not ordered according to the time when
messages were contrieved, instead it is ordered in any order depending on
when syslog wants to write the message to the file. The mess you are seeing
propably has something to do with the fact that /var/log/messages isn't
mounted immediately at boot, and thus cannot be written before syslog starts
and has access to the file.

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


