Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTJAAE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJAAEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:04:48 -0400
Received: from main.gmane.org ([80.91.224.249]:41631 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261819AbTJAAD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:03:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: [BUG?] modprobe sch_htb fails
Date: Wed, 01 Oct 2003 02:02:56 +0200
Message-ID: <bld5lc$p3n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030916
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today i recompiled my kernel (version 2.4.22) to make my first steps 
towards traffic shaping.

I found out, that the module sch_htb cannot be loaded.
I can't tell why. Every option under "Networking Options"->"QoS and/or 
fairqueuing" was either marked to be compiled statically or as a module 
if possible.

I guess it's only a "bug" in the dependencies or something similar.
If you need anything to reproduce the "bug", i can send you my .config 
or anything you need.


"modprobe sch_htb" failed with:

/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
qdisc_get_rtab
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
psched_time_base
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
unregister_qdisc
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
qdisc_put_rtab
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
register_qdisc
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
pfifo_qdisc_ops
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
psched_time_mark
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: unresolved symbol 
qdisc_kill_estimator
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: insmod 
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o failed
/lib/modules/2.4.22/kernel/net/sched/sch_htb.o: insmod sch_htb failed


