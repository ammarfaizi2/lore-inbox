Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUFPDAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUFPDAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266088AbUFPDAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:00:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:43756 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266096AbUFPC7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:59:13 -0400
Date: Tue, 15 Jun 2004 19:58:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: foo@porto.bmb.uga.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-Id: <20040615195822.7e7151aa.akpm@osdl.org>
In-Reply-To: <20040616024842.GC13672@porto.bmb.uga.edu>
References: <20040615062236.GA12818@porto.bmb.uga.edu>
	<20040615030932.3ff1be80.akpm@osdl.org>
	<20040615150036.GB12818@porto.bmb.uga.edu>
	<20040615162607.5805a97e.akpm@osdl.org>
	<20040616024842.GC13672@porto.bmb.uga.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

foo@porto.bmb.uga.edu wrote:
>
> On Tue, Jun 15, 2004 at 04:26:07PM -0700, Andrew Morton wrote:
> > OK, well I'd be suspecting that either devicemapper or raid5 lost an I/O
> > completion, causing that page to never be unlocked.
> > 
> > Please try the latest -mm kernel, which has a few devicemapper changes,
> > although they are unlikely to fix this.
> 
> OK, this was fun...
> 
> LILO 22.2 boot: linux-mm
> Loading Linux-mm.................................
> 
> This is all I see on the serial console.  The machine did boot, though;
> a few minutes later I see this (and only this) from my syslog server:
> 
> xarello kernel: bonding: bond0: link status definitely up for interface
> eth1.
> 
> Getty didn't come up on the serial console, and it's refusing ssh
> requests, although it seems to be dropping lots of packets.

Lovely.  Please send over the kernel boot command line.

