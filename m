Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265840AbRGDPbN>; Wed, 4 Jul 2001 11:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265845AbRGDPbD>; Wed, 4 Jul 2001 11:31:03 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:46271 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265840AbRGDPax>; Wed, 4 Jul 2001 11:30:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Florian Schmitt <florian@galois.de>
To: Francois Romieu <romieu@cogenit.fr>
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
Date: Wed, 4 Jul 2001 17:30:35 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <3B40611D.F1485C1B@N-Club.de> <01070311300700.00765@phoenix> <20010704111931.A27723@se1.cogenit.fr>
In-Reply-To: <20010704111931.A27723@se1.cogenit.fr>
MIME-Version: 1.0
Message-Id: <01070417303500.08285@phoenix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you specify what you mean by "very high network traffic" in terms
> of interrupt rate and Mb/s ?
> Ftp on full CD content or gross ping -f doesn't kill it under 2.4 here.
> autonegociation sucks sometimes.

That's about what I did, except that I saved the data to a nfs mounted disk.

> Different switch/cable/*motherboard* ?

Probably not. I tried the drivers from http://www.scyld.com/network/ , and 
the problem disappeared (thanks to Jeff Garzik for the suggestion). 
I haven't tried 2.4.x again, but last time I did (2.4.6-pre6 or so), it 
didn't even finish importing my nfs shares on startup.

In case you are interested, here is the output of the 2.2.18 drivers, when 
the card hangs:

Jun  4 16:44:34 siechfried kernel: eth0: Transmit timeout using MII device, 
Tx status 0005.
Jun  4 16:44:34 siechfried kernel: eth0: Restarting the EPIC chip, Rx 
2026941/2026941 Tx 497569/497585.
Jun  4 16:44:34 siechfried kernel: eth0: epic_restart() done, cmd status 
000a, ctl 0512 interrupt 240000.
Jun  4 16:44:39 siechfried kernel: eth0: Transmit timeout using MII device, 
Tx status 0005.
Jun  4 16:44:39 siechfried kernel: eth0: Restarting the EPIC chip, Rx 
2026941/2026941 Tx 497569/497585.
Jun  4 16:44:39 siechfried kernel: eth0: epic_restart() done, cmd status 
000a, ctl 0512 interrupt 240000.
Jun  4 16:44:44 siechfried kernel: eth0: Transmit timeout using MII device, 
Tx status 0005.
etc...

The driver from scyld.com did also issue such a warning, but only once and 
everythings seems to be back to normal afterwards:

Jul  4 15:13:06 siechfried kernel: eth0: Tx hung, 25721 vs. 25713.
Jul  4 15:13:06 siechfried kernel: eth0: Transmit timeout using MII device, 
Tx status 0003.
Jul  4 15:13:06 siechfried kernel: eth0: Restarting the EPIC chip, Rx 
24507/24507 Tx 25713/25721.
Jul  4 15:13:06 siechfried kernel: eth0: epic_restart() done, cmd status 
000a, ctl 0512 interrupt 240000.

I hope this helps,
  Flo
