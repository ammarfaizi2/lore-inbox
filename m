Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293056AbSCEMiw>; Tue, 5 Mar 2002 07:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293058AbSCEMim>; Tue, 5 Mar 2002 07:38:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11137 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293056AbSCEMib>;
	Tue, 5 Mar 2002 07:38:31 -0500
Date: Tue, 05 Mar 2002 04:36:04 -0800 (PST)
Message-Id: <20020305.043604.08321823.davem@redhat.com>
To: sten@blinkenlights.nl
Cc: jochen@scram.de, linux-kernel@vger.kernel.org,
        parisc-linux@lists.parisc-linux.org
Subject: Re: IPv6 Sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44-Blink.0202041155020.19625-100000@deepthought.blinkenlights.nl>
In-Reply-To: <Pine.NEB.4.33.0202041002120.2571-100000@www2.scram.de>
	<Pine.LNX.4.44-Blink.0202041155020.19625-100000@deepthought.blinkenlights.nl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sten <sten@blinkenlights.nl>
   Date: Mon, 4 Feb 2002 11:58:10 +0100 (CET)
   
   The reason I ask this is because I have been trying to setup a
   tunnel, and I cant get it to work either with ifconfig or iproute.
   
   [root@towel ip]# ip tunnel add blink mode sit remote x.x.x.x dev
   eth0
   ioctl: Invalid argument

The reason this fails is because SIOCADDTUNNEL uses SIOCDEVPRIVATE
which can't be translated properly to/from 32-bit apps running
on 64-bit kernels.
