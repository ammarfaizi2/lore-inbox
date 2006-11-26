Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934384AbWKZQGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934384AbWKZQGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 11:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934398AbWKZQGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 11:06:36 -0500
Received: from vs2067197.netfabrik.de ([85.25.67.197]:20669 "EHLO obenhuber.de")
	by vger.kernel.org with ESMTP id S934384AbWKZQGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 11:06:36 -0500
Subject: [RFC] dynsched - different cpu schedulers per cpuset
From: Felix Obenhuber <felix@obenhuber.de>
To: linux-kernel@vger.kernel.org
Cc: dynsched-devel@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Nov 2006 17:06:29 +0100
Message-Id: <1164557189.10306.12.camel@athrose>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

we're a student group witch is working on a research project concerning
the ability to switch the cpu scheduler of the linux kernel at runtime.

We use Peter Williams Plugsched patch [1] to get an interface for the
different scheduler implementations. Some month ago we started to modify
the code to allow different scheduler running on each cpu on an SMP
system. The cpu<->scheduler mapping is controlled via cpusets. Thus you
can switch the scheduler for a cpuset containing multiple cpus and
keep the rest untouched.

The project is hosted on Sourceforge [2] and the current patch applies
against 2.6.18 patched with plugsched.

Threre are still lots of issues - especially the migration of tasks
between cpus with different schedulers is quite buggy.

Switching the scheduler on non smp configured systems works fine (tested
 x86) 

Refer the project instruction site [3] for further information and usage /
patch instructions.

We'd be quite happy, if someone could take a look at what we've done
to gain some feedback/suggestions about the used techniques and
implementation. Some changes are already queued.

The project documentation (description/benchmarks/usage/bugs) is in
progress and will be completed in about 4 weeks.

Thanks a lot.

cheers,

Felix


[1] http://sourceforge.net/projects/cpuse/
[2] http://sourceforge.net/projects/dynsched/
[3] http://dynsched.sourceforge.net
-- 
Felix Obenhuber felixatobenhuber.de
www.obenhuber.de/felix
GPG: F696D489
Sat Nov 18 15:56:31 CET 2006
