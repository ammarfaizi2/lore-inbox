Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266079AbUFPCsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266079AbUFPCsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbUFPCsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:48:51 -0400
Received: from crianza.bmb.uga.edu ([128.192.34.109]:2433 "EHLO crianza")
	by vger.kernel.org with ESMTP id S266079AbUFPCss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:48:48 -0400
Date: Tue, 15 Jun 2004 22:48:42 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: processes hung in D (raid5/dm/ext3)
Message-ID: <20040616024842.GC13672@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20040615062236.GA12818@porto.bmb.uga.edu> <20040615030932.3ff1be80.akpm@osdl.org> <20040615150036.GB12818@porto.bmb.uga.edu> <20040615162607.5805a97e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615162607.5805a97e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 04:26:07PM -0700, Andrew Morton wrote:
> OK, well I'd be suspecting that either devicemapper or raid5 lost an I/O
> completion, causing that page to never be unlocked.
> 
> Please try the latest -mm kernel, which has a few devicemapper changes,
> although they are unlikely to fix this.

OK, this was fun...

LILO 22.2 boot: linux-mm
Loading Linux-mm.................................

This is all I see on the serial console.  The machine did boot, though;
a few minutes later I see this (and only this) from my syslog server:

xarello kernel: bonding: bond0: link status definitely up for interface
eth1.

Getty didn't come up on the serial console, and it's refusing ssh
requests, although it seems to be dropping lots of packets.

Now I have to go into work and hit the reset switch :(

-ryan
