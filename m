Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVHQAxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVHQAxv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVHQAxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:53:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9200 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750783AbVHQAxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:53:50 -0400
Message-ID: <43028A94.1050603@mvista.com>
Date: Tue, 16 Aug 2005 17:53:40 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: [patch] KGDB for Real-Time Preemption systems
References: <20050811110051.GA20872@elte.hu>
In-Reply-To: <20050811110051.GA20872@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have put a version of KGDB for x86 RT kernels here:
http://source.mvista.com/~ganzinger/

The common_kgdb_cfi_.... stuff creates debug records for entry.S and 
friends so that you can "bt" through them.  Apply in this order:
Ingo's patch
kgdb-ga-rt.patch
common_kgdb_cfi_annotations.patch

This is, more or less, the same kgdb that is in Andrew's mm tree changed 
to fix the RT issues.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
