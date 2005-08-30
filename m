Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVH3QEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVH3QEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVH3QEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:04:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11735 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932190AbVH3QEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:04:39 -0400
Subject: Re: KLive: Linux Kernel Live Usage Monitor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Sven Ladegast <sven@linux4geeks.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050830151035.GO8515@g5.random>
References: <20050830030959.GC8515@g5.random>
	 <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
	 <20050830082901.GA25438@bitwizard.nl>
	 <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de>
	 <20050830094058.GA29214@bitwizard.nl>  <20050830151035.GO8515@g5.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 17:33:38 +0100
Message-Id: <1125419618.8276.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-30 at 17:10 +0200, Andrea Arcangeli wrote:
> It's certainly much easier to tweak the kernel config before compiling
> the kernel than to edit the mess in /etc/init.d/* with all the
> gratuitous differences of the userland flavours.

Just follow the LSB specification and about the only thing thats totally
out of field is Slackware.

> easy to setup. It'll be a bit lighter too, twisted currently takes 6m of
> RSS on a x86.

Right thats my first reaction, 6Mbytes of unauditable weirdness versus a
tiny C program or a shell script using netcat.

echo "Reporting boot: "
(echo "BOOT:"$(cat /etc/lum-serial)":"$(uname -a)"::") | nc -u -w 10
testhost.example.com 7658

> I could perhaps write an auto-installer script, that fetches the tac
> file with wget and adds a line to /etc/init.d/boot.local to make life
> easier.

For one distro perhaps. Using a proper init service script makes it work
for pretty much everyone. 


