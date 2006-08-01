Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWHASLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWHASLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHASLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:11:37 -0400
Received: from blinkenlights.ch ([62.202.0.18]:42737 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S1751339AbWHASLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:11:36 -0400
Date: Tue, 1 Aug 2006 20:11:34 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vonbrand@inf.utfsm.cl, bernd-schubert@gmx.de, reiserfs-list@namesys.com,
       jbglaw@lug-owl.de, clay.barnes@gmail.com, rudy@edsons.demon.nl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
Message-Id: <20060801201134.d3523944.reiser4@blinkenlights.ch>
In-Reply-To: <1154446189.15540.43.camel@localhost.localdomain>
References: <200607312314.37863.bernd-schubert@gmx.de>
	<200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
	<20060801165234.9448cb6f.reiser4@blinkenlights.ch>
	<1154446189.15540.43.camel@localhost.localdomain>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You do it turns out. Its becoming an issue more and more that the sheer
> amount of storage means that the undetected error rate from disks,
> hosts, memory, cables and everything else is rising.

IMHO the possibility to hit such a random-so-far-undetected-corruption
is very low with one of the big/expensive raid systems as they are
doing fancy stuff like 'disk scrubbing' and usually do fail disks
at very early stages..

 * I've seen storage systems from a BIG vendor die due to
   firmware bugs
 * I've seen FC-Cards die.. SAN-switches rebooted.. People used
   my cables to do rope skipping
 * We had Fire, non-working UPS and faulty diesel generators..

but so far the FSes (and applications) on the Storage never
complained about corrupted data.

..YMMV..

Btw: I don't think that Reiserfs really behaves this bad
with broken hardware. So far, Reiser3 survived 2 broken Harddrives
without problems while i've seen ext2/3 die 4 times so far...
(= everything inside /lost+found). Reiser4 survived
 # mkisofs . > /dev/sda

Lucky me.. maybe..


To get back on-topic:

Some people try very hard to claim that the world doesn't need
Reiser4 and that you can do everything with ext3.

Ext3 may be fine for them but some people (like me) really need Reiser4
because they got applications/workloads that won't work good (fast) on ext3.

Why is it such a big thing to include a filesystem?
Even if it's unstable: does anyone care? Eg: the HFS+ driver
is buggy (corrupted the FS of my OSX installation 3 times so far) but
does this buggyness affect people *not* using it? No.

Regards,
 Adrian
