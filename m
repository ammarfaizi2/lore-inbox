Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWASEet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWASEet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWASEet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:34:49 -0500
Received: from fsmlabs.com ([168.103.115.128]:34688 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1161132AbWASEes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:34:48 -0500
X-ASG-Debug-ID: 1137645255-25837-10-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 18 Jan 2006 20:39:14 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, anton@au1.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, michael@ellerman.id.au,
       Linus Torvalds <torvalds@osdl.org>, ntl@pobox.com, serue@us.ibm.com,
       Linux PPC64 <linuxppc64-dev@ozlabs.org>, paulus@au1.ibm.com
X-ASG-Orig-Subj: Re: [patch] turn on might_sleep() in early bootup code too
Subject: Re: [patch] turn on might_sleep() in early bootup code too
In-Reply-To: <20060118104319.GB7885@elte.hu>
Message-ID: <Pine.LNX.4.64.0601182027570.20777@montezuma.fsmlabs.com>
References: <200601181119.39872.michael@ellerman.id.au> <20060118033239.GA621@cs.umn.edu>
 <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org>
 <20060118072815.GR2846@localhost.localdomain> <20060117233734.506c2f2e.akpm@osdl.org>
 <20060118080828.GA2324@elte.hu> <20060118002459.3bc8f75a.akpm@osdl.org>
 <20060118091834.GA21366@elte.hu> <20060118023509.50fe2701.akpm@osdl.org>
 <20060118104319.GB7885@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.7530
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Ingo Molnar wrote:

> lock_cpu_hotplug() has design problems i think: hotplug-locked sections 
> are slowly spreading in the kernel, encompassing more and more code :-) 
> Shouldnt the CPU hotplug lock be a spinlock to begin with?

The way it's used certainly is bizarre, but a spinlock would be harder to 
work with as a lot of the code protected by it sleep.
