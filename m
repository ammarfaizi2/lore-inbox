Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267318AbTAVFEs>; Wed, 22 Jan 2003 00:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTAVFEs>; Wed, 22 Jan 2003 00:04:48 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:45572
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267318AbTAVFEq>; Wed, 22 Jan 2003 00:04:46 -0500
Date: Wed, 22 Jan 2003 00:13:32 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>, <davidm@hpl.hp.com>,
       Ralf Baechle <ralf@uni-koblenz.de>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH][2.5][0/18] smp_call_function_on_cpu + removal of nonatomic/retry
Message-ID: <Pine.LNX.4.44.0301211850010.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	The following patches introduce smp_call_function_on_cpu which 
provides a facility for sending IPIs to a group or single cpu encapsulated 
within a bitmask. At present there are a number of arch specific functions 
which achieve the same effect, the name was lifted from Alpha.

As per Manfred's request i have also taken the liberty of removing the 
nonatomic/retry parameter from smp_call_function since it's used 
as 'nonatomic' on a number of architectures and used as 'retry' on others 
whilst not actually doing much on a majority of said architectures.

I have not being able to compile or test the other architectures apart 
from i386 (surprise, surprise), but there should only be minimal, if any, 
syntax errors.

Please consider for inclusion, if a particular arch maintainer notes 
breakage in my implementation please point it out and i'll do the grunt 
work.

Thanks,
	Zwane
-- 
function.linuxpower.ca








