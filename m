Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263500AbTCNVBb>; Fri, 14 Mar 2003 16:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263504AbTCNVBb>; Fri, 14 Mar 2003 16:01:31 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:63494 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S263500AbTCNVBa>; Fri, 14 Mar 2003 16:01:30 -0500
Subject: Re: [patch] Summit support for pcibus <-> cpumask topology
From: James Bottomley <James.Bottomley@steeleye.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Mar 2003 15:12:10 -0600
Message-Id: <1047676332.5409.374.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> This patch adds a new file, arch/i386/kernel/summit.c, for 
> summit-specific code.  Adds some structures to mach_mpparse.h.  Also 
> adds a hook in setup_arch() to dig out the PCI info, and stores it in 
> the mp_bus_id_to_node[] array, where it can be read by the topology 
> functions.

Wouldn't this file be better in arch/i386/mach-summit in keeping with
all the other subarch stuff?

While you're creating a separate file for summit, could you move the
summit specific variables (mpparse.c:x86_summit is the only one, I
think) into it so we can clean all the summit references out of the main
line?

Thanks,

James


