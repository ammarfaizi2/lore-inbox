Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbREBLKG>; Wed, 2 May 2001 07:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbREBLJ5>; Wed, 2 May 2001 07:09:57 -0400
Received: from e215012.upc-e.chello.nl ([213.93.215.12]:1545 "EHLO
	procyon.wilson.nl") by vger.kernel.org with ESMTP
	id <S131643AbREBLJi>; Wed, 2 May 2001 07:09:38 -0400
From: "Michel Wilson" <michel@procyon14.yi.org>
To: "Sim, CT \(Chee Tong\)" <CheeTong.Sim@sin.rabobank.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux NAT questions- (kernel upgrade??)
Date: Wed, 2 May 2001 13:09:33 +0200
Message-ID: <NEBBLEJBILPLHPBNEEHIIEGHCEAA.michel@procyon14.yi.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1E8992B3CD28D4119D5B00508B08EC5627E8A4@sinxsn02.ap.rabobank.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.. I follow your instruction, but I encounter this issue, my kernel need
> to be upgrade? MAy I know how to determine the current kernel version and
> how to upgrade it??

You can see the current kernel version by doing uname -a. It is also shown
at boot time.

>
>
> [root@guava /root]# iptables -t nat -A PREROUTING -p tcp --dst
> 1.1.1.160 -i
> eth1 -j D
> NAT --to-destination 192.168.200.2
> iptables v1.1.1: can't initialize iptables table `nat': iptables who? (do
> you need to insm
> od?)
> Perhaps iptables or your kernel needs to be upgraded.
>
>
> [root@guava simc]# rpm -ivh iptables-1_2_0-6_i386.rpm
> error: failed dependencies:
>         kernel >= 2.4.0 is needed by iptables-1.2.0-6
For iptables you'll need kernel >= 2.4.0, as stated. I don't know if RedHat
has a precompiled rpm somewhere (i don't use RedHat) but i would think so.
You might ask your local RedHat guru ;-).
Other options are:
- build your own 2.4.x (see Kernel-HOWTO, if it's not too outdated)
- use ipchains.

I don't know ipchains enough to tell you how to do it, i don't even know if
it's possible.... But
http://www.linuxdoc.org/HOWTO/IP-Masquerade-HOWTO-6.html#ss6.8 may be of
interest to you.

Greetings,

Michel Wilson.

