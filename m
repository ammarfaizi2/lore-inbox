Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWHFSFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWHFSFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWHFSFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 14:05:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28033 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751670AbWHFSFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 14:05:08 -0400
Date: Sun, 6 Aug 2006 14:05:02 -0400
From: Dave Jones <davej@redhat.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060806180502.GK13393@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com> <20060805021051.GA13393@redhat.com> <20060805022356.GC13393@redhat.com> <20060805024947.GE13393@redhat.com> <20060805064727.GF13393@redhat.com> <6bffcb0e0608060959m164436baj9c4c602496e87f5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0608060959m164436baj9c4c602496e87f5d@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 06:59:54PM +0200, Michal Piotrowski wrote:

 > > Michal, could you apply this diff.. http://lkml.org/lkml/diff/2006/8/4/381/1
 > > (change the '120' to '60' first), and send me the debug spew that you get ?
 > > You'll have to wait until a minute of uptime has passed. Oh, and edit
 > > include/linux/jiffies.h to change INITIAL_JIFFIES to '0'.
 > 
 > I hope that this one will help
 > 
 > BUG: using smp_processor_id() in preemptible [00000001] code: cpuspeed/1433
 > caller is lock_cpu_hotplug+0x25/0xc5

Not really, that one seems to be a bug in my debugging patch :-/

		Dave

-- 
http://www.codemonkey.org.uk
