Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTKFUMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbTKFUL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:11:57 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:31654 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S263792AbTKFULw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:11:52 -0500
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [DMESG] cpumask_t in action
References: <20031105222202.GA24119@sgi.com>
	<20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 06 Nov 2003 15:11:48 -0500
In-Reply-To: <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
Message-ID: <yq0y8utp88r.fsf@trained-monkey.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <willy@debian.org> writes:

Matthew> On Wed, Nov 05, 2003 at 02:22:02PM -0800, Jesse Barnes wrote:

Matthew> There's a number of things here that annoy me.  One is the
Matthew> stupid "Processor 8192/1 is spinning up".  I would expect
Matthew> "Processor 2/96 is spinning up", but why have this line at
Matthew> all?  I'd also like to see "Bringing up 3", "Processor 1 has
Matthew> spun up..." and "CPU 1 IS NOW UP!" go away.  That'd cut us
Matthew> down to:

>> CPU 3: 61 virtual and 50 physical address bits CPU 3: nasid 2,
>> slice 2, cnode 1 CPU 3: base freq=200.000MHz, ITC ratio=15/2, ITC
>> freq=1500.000MHz+/--1ppm Calibrating delay loop... 2241.08 BogoMIPS
>> CPU3: CPU has booted.  Starting migration thread for cpu 3

Matthew> A 40% reduction in per-cpu verbosity ;-)

Why not turn it the other way and just report the success of booted
CPUs and more detailed results for the CPUs that failed? I know there
are cases where you want the debug info in case of tracking kernel
bugs, but one could stick a compile time debug flag into the code for
that case, 960 - 40% = 576 lines of guff is still way too much IMHO,
especially over a serial console.

Cheers,
Jes
