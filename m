Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTFPTjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbTFPTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:39:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264198AbTFPTj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:39:27 -0400
Date: Mon, 16 Jun 2003 12:53:15 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Peter Lundkvist <p.lundkvist@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
Message-Id: <20030616125315.36d8c077.shemminger@osdl.org>
In-Reply-To: <3EEE173A.8040802@telia.com>
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi>
	<20030615191125.I5417@flint.arm.linux.org.uk>
	<87el1vcdrz.fsf@jumper.lonesom.pp.fi>
	<20030615212814.N5417@flint.arm.linux.org.uk>
	<87he6qc3bb.fsf@jumper.lonesom.pp.fi>
	<20030616085403.A5969@flint.arm.linux.org.uk>
	<3EEE173A.8040802@telia.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps the changes to network hotplug are related.  Did  you see this?
> 
> This patch causes an external script API change.
> Because network device go through the standard path, the action passed to the script
> is no longer register or unregister but is now "add" or "remove" like other devices.
> This is a good thing.  When testing (at least on RHAT) just change /etc/hotplug/net.agent
> case statement:
> 	
> case $ACTION in
> add|register)
>     # Don't do anything if the network is stopped
>     if [ ! -f /var/lock/subsys/network ]; then
> 	exit 0
>     fi
