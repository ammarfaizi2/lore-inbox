Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTICSJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTICSIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:08:06 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44046 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264115AbTICSHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:07:51 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Fix up power managment in 2.6
Date: 3 Sep 2003 17:59:09 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bj5a5d$8b8$1@gatekeeper.tmr.com>
References: <20030902094701.GD145@elf.ucw.cz> <Pine.LNX.4.44.0309020825280.5614-100000@cherise> <20030903174904.GH30629@atrey.karlin.mff.cuni.cz>
X-Trace: gatekeeper.tmr.com 1062611949 8552 192.168.12.62 (3 Sep 2003 17:59:09 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030903174904.GH30629@atrey.karlin.mff.cuni.cz>,
Pavel Machek  <pavel@suse.cz> wrote:
| Hi!
| 
| > > -void software_resume(void)
| > > +int __init swsusp_restore(void)
| > >  {
| > > -       if (num_online_cpus() > 1) {
| > > -               printk(KERN_WARNING "Software Suspend has
| > > malfunctioning SMP support. Disabled :(\n");
| > > -               return;
| > > -       }
| > > 
| > > I can not easily see where you moved this check.
| > 
| > Read the rest of the patches, and the changelogs (I do believe it's in 
| > them). It's in kernel/power/main.c::enter_state(), so all PM handlers can 
| > use it. 
| 
| Notice that this is done during resume. You are free to suspend with 1
| cpu, then attempt to resume with 2 cpus. Not *too* likely to happen,
| but....

Would it matter if you did? Unless you are running an SMP kernel? I
guess at some point the laptop CPUs will have HT, and SMP will be more
of an issue than it is now.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
