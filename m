Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312392AbSDXQql>; Wed, 24 Apr 2002 12:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDXQqk>; Wed, 24 Apr 2002 12:46:40 -0400
Received: from viruswall2.epcnet.de ([62.132.156.25]:16140 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S312392AbSDXQqi>; Wed, 24 Apr 2002 12:46:38 -0400
Date: Wed, 24 Apr 2002 18:46:29 +0200
From: jd@epcnet.de
To: greearb@candelatech.com
Subject: AW: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <739225949.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <3CC6DAD8.2010502@candelatech.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.7
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <greearb@candelatech.com>
> Gesendet: 24.04.2002 18:20
> Some drivers work, more are being fixed.  Others have to be
> patched.  All work if you set the MTU of the link to 1496.

I made some tests with Windows2000. I have to set the MTU manually (in the registry) to 1496 to get all working. Thats ok for a few clients, but not for many.

> We can use testing of patched drivers, so if you do patch any
> and have good results, then let us know and the driver changes might
> get pushed into the kernel sooner.

I don't use a kernel driver, i use a driver from a manufacturer. ZNYX provides some with Source, but i'm not the nic-register-voodoo-man to allow this driver to receive larger frames. I just changed some defines, but this doesn't work.

I use the ZNYX driver cause i didn't got Jeffs Tulip driver to work correctly with my card (346Q). Maybe the tulip driver works better now, but this is not the point.

The point is that i get no information if VLAN works with a nic/driver (including third party drivers) without MTU limitations.

There should really be a flag, a tag or a capability thing in the driver which says "VLAN not possible", when vconfig tries to add a VLAN. So if i get a third party driver, vconfig would report if i can use it or not.

Today i have to test it with every nic/driver - not so nice. But think of others, who are not so involved in networking things, they setup a vlan like you (and e.g. Cisco or 3COM) described and get problems with ftp, large pings, etc. pp.

