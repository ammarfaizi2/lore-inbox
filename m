Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315132AbSDWJjf>; Tue, 23 Apr 2002 05:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315135AbSDWJje>; Tue, 23 Apr 2002 05:39:34 -0400
Received: from whiskey.openminds.be ([212.35.126.198]:63165 "EHLO
	whiskey.openminds.be") by vger.kernel.org with ESMTP
	id <S315132AbSDWJje>; Tue, 23 Apr 2002 05:39:34 -0400
Date: Tue, 23 Apr 2002 11:39:35 +0200
From: Frank Louwers <frank@openminds.be>
To: linux-kernel@vger.kernel.org
Subject: BUG: 2 NICs on same network
Message-ID: <20020423113935.A30329@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-PGP2: 1024R/1A899409  C3 D8 FA D3 E0 0E 40 C5  10 32 83 74 36 F0 E5 95
X-oldGPG: 1024D/3F6A7EDD  D597 566A BDF5 BBFB C308  447A 5E81 1188 3F6A 7EDD
X-GPG: 1024D/E592712F  E857 266C 04BE 0772 B9C4  E798 3D34 D5E5 E592 712F
Organisation: Openminds - http://www.openminds.be/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We recently stummed across a rather annoying bug when 2 nics are on
the same network.

Our situation is this: we have a server with 2 nics, each with a
different IP on the same network, connected to the same switch. Let's
assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
netmask of 255.255.255.0.

Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
matter what!

Even if we disconnect the cable for eth1, 1.2.3.2 still replies to
pings, ssh, web, ...

We tested this on IA32 architecture, different 2.4.x kernels and
different nics ...

Is this a bug or a known issue? If it is not a bug, how can it be
solved?

Kind Regards,
Frank Louwers

-- 
Openminds bvba                www.openminds.be
Tweebruggenstraat 16  -  9000 Gent  -  Belgium
