Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272423AbRIFSM2>; Thu, 6 Sep 2001 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272261AbRIFSMS>; Thu, 6 Sep 2001 14:12:18 -0400
Received: from clavin.efn.org ([206.163.176.10]:32961 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S272424AbRIFSME>;
	Thu, 6 Sep 2001 14:12:04 -0400
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15255.48233.706962.451093@tzadkiel.efn.org>
Date: Thu, 6 Sep 2001 11:11:53 -0700
To: wietse@porcupine.org (Wietse Venema)
Cc: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
In-Reply-To: <20010906172316.E0B74BC06C@spike.porcupine.org>
In-Reply-To: <E15f2WT-0008Tp-00@the-village.bc.nu>
	<20010906172316.E0B74BC06C@spike.porcupine.org>
X-Mailer: VM 6.95 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wietse Venema writes:
 > If an MTA receives a mail relaying request for user@domain.name
 > then it would be very useful if Linux could provide the MTA with
 > the necessary information to distinguish between local subnetworks
 > and the rest of the world. Requiring the local sysadmin to enumerate
 > all local subnetwork blocks by hand is not practical.

I think you're making a couple of unjustified assumptions here:

First, you shouldn't assume that all the other hosts on a local subnet
are under the same administrative control as the host with the MTA in
question (think of a host in a colocation facility), and therefore you
also shouldn't assume that you should allow mail relaying to or from
other hosts on the same subnet by default.

Second, you can't assume that an administrator can or will put all hosts
he wants to allow relaying to or from on the same subnet as the MTA.

It's not only practical to require the sysadmin to enumerate which hosts
or networks he wants to permit relaying from, it's the only solution
that gives the sysadmin the required level of control over relaying
based on client IP addresses.
