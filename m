Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSKRIOe>; Mon, 18 Nov 2002 03:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSKRIOe>; Mon, 18 Nov 2002 03:14:34 -0500
Received: from holomorphy.com ([66.224.33.161]:63453 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261640AbSKRIOd>;
	Mon, 18 Nov 2002 03:14:33 -0500
Date: Mon, 18 Nov 2002 00:18:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, rml@tech9.net, riel@surriel.com, akpm@zip.com.au
Subject: unusual scheduling performance
Message-ID: <20021118081854.GJ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, mingo@elte.hu, rml@tech9.net,
	riel@surriel.com, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16x, 2.5.47 kernel compiles take about 26s when the machine is
otherwise idle.

On 32x, 2.5.47 kernel compiles take about 48s when the machine is 
otherwise idle.

When a single-threaded task consumes an entire cpu, kernel compiles
take 36s on 32s when the machine is idle aside from the task consuming
that cpu and the kernel compile itself.

I suspect the scheduler, because cpu reporting in top(1) shows that a
two or more cpu-intensive tasks are concentrated on the same cpu, and
some long-lived tasks appear to be "bouncing" across cpus. If someone
with knowledge and/or expertise with respect to scheduling semantics
could look into this, I would be much obliged. Resolving this would
likely address many SMP and/or NUMA scheduling performance issues.


Thanks,
Bill
