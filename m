Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWHAOwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWHAOwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWHAOwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:52:39 -0400
Received: from blinkenlights.ch ([62.202.0.18]:36021 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S1161024AbWHAOwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:52:39 -0400
Date: Tue, 1 Aug 2006 16:52:34 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: bernd-schubert@gmx.de, reiserfs-list@namesys.com, jbglaw@lug-owl.de,
       clay.barnes@gmail.com, rudy@edsons.demon.nl, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
Message-Id: <20060801165234.9448cb6f.reiser4@blinkenlights.ch>
In-Reply-To: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
References: <200607312314.37863.bernd-schubert@gmx.de>
	<200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > While filesystem speed is nice, it also would be great if reiser4.x would be 
> > very robust against any kind of hardware failures.
> 
> Can't have both.

..and some people simply don't care about this:

If you are running a 'big' Storage-System with battery protected
WriteCache, Mirroring between 2 Datacenters, snapshotting.. etc..
you don't need your filesystem beeing super-robust against bad sectors
and such stuff because:

 a) You've paid enough money to let the storage care about 
    Hardware issues.
 b) If your storage is on fire you can do a failover using the mirror.
 c) And if someone ran dd if=/dev/urandom of=/dev/sda you could
    even rollback your Snapshot.
    (Btw: i did this once to a Reiser4 filesystem (overwritten about
    1.2gb). fsck.reiser4 --rebuild-sb was able to fix it.)


..but what you really need is a flexible and **fast** filesystem: Like
Reiser4.

(Yeah.. yeah.. i know: ext3 is also flexible and fast.. but Reiser4
simply is *MUCH* faster than ext3 for 'my' workload/application).

Regards,
 Adrian

