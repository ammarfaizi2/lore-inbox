Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTBNRBM>; Fri, 14 Feb 2003 12:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTBNRBL>; Fri, 14 Feb 2003 12:01:11 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:19041
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261640AbTBNRBG>; Fri, 14 Feb 2003 12:01:06 -0500
Date: Fri, 14 Feb 2003 12:09:19 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5][14/14] smp_call_function_on_cpu - x86_64
In-Reply-To: <20030214144723.GA25691@wotan.suse.de>
Message-ID: <Pine.LNX.4.50.0302141208040.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140412190.3518-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0302140751530.3518-100000@montezuma.mastecende.com>
 <20030214144723.GA25691@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Andi Kleen wrote:

> On Fri, Feb 14, 2003 at 07:52:15AM -0500, Zwane Mwaikambo wrote:
> > One liner to fix num_cpus == 0 on SMP kernel w/ UP box
> 
> Shouldn't num_cpus be 1 in that case ?

We mask out current cpu first like so;

mask &= ~(1UL << smp_processor_id());
num_cpus = hweight(mask);
if (num_cpus == )
	return 0;

So really it's number of eligible IPI cpus

	Zwane
-- 
function.linuxpower.ca
