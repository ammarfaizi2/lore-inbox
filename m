Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTIYGzP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 02:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTIYGzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 02:55:14 -0400
Received: from AGrenoble-101-1-1-66.w193-251.abo.wanadoo.fr ([193.251.23.66]:19850
	"EHLO awak") by vger.kernel.org with ESMTP id S261719AbTIYGzM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 02:55:12 -0400
Subject: Re: rfc: test whether a device has a partition table
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0309241710380.1688-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309241710380.1688-100000@home.osdl.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1064472834.622.30.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 08:53:55 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 25/09/2003 à 02:18, Linus Torvalds a écrit :

> The _worst_ thing that can happen is that you have four extra (totally 
> bogus) partitions, and you end up using the whole device.

That means that hotplug/automount will have to re-parse the partition
table itself to mount only the real partitions. So the job is done
twice, in-kernel and in userspace.

Have no doubts that *real* users (like the police force mentionned by
Andries) will let their system automount their USB disks, they'll never
figure out which devices look bogus (dev/sd what ?!?) and which one to
mount.

If the partition discovery and validity check is done in userspace, why
still do it in-kernel ?

	Xav

