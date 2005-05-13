Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVEMTq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVEMTq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVEMTkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:40:37 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:62427 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262459AbVEMTg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:36:56 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Scott Robert Ladd <lkml@coyotegulch.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hyper-Threading Vulnerability
Date: Sat, 14 May 2005 05:36:50 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <57v981p5tjaq44k8cmt0vo70kd43tjj41n@4ax.com>
References: <1115963481.1723.3.camel@alderaan.trey.hu>	 <m164xnatpt.fsf@muc.de> <1116009347.1448.489.camel@localhost.localdomain> <4284F6B5.2080308@coyotegulch.com>
In-Reply-To: <4284F6B5.2080308@coyotegulch.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005 14:49:25 -0400, Scott Robert Ladd <lkml@coyotegulch.com> wrote:

>Alan Cox wrote:
>> HT for most users is pretty irrelevant, its a neat idea but the
>> benchmarks don't suggest its too big a hit
>
>On real-world applications, I haven't seen HT boost performance by more
>than 15% on a Pentium 4 -- and the usual gain is around 5%, if anything
>at all. HT is a nice idea, but I don't enable it on my systems.

P4-HT is great for winxp, a runaway process only gets half the CPU 
resources, keeps the system responsive.  I like HT for that reason, 
perhaps that's what it was designed for?  Hardware fix for msft 'OS' :o)

Recently on single AMD CPU box, 2.6.latest-mm, diff got stuck, no 
disk activity, 100% CPU, started another terminal, recompiled kernel 
with 8K stacks and rebooted, the whole time the unkillable 'diff' 
was using just over 1/2 of resources.  top showed all 1GB RAM in use, 
no swap activity, nothing odd in /proc/whatever -- only happened once.

I suspected 4k stacks as only change before 'crash' was turning on 
samba server day before, but I didn't trace 'problem' as it wasn't 
really a crash.  Impressive -- seeing 2.6 handling a stupid process, 
business as usual for everything else.  Haven't had a problem since 
changing to 8K stacks.  nfs, samba and ssh terminals on reiserfs 3.6
on via sata.  May have had nvidia driver installed at the time, I 
now load that only when X running (rare), mostly headless use.

--Grant.

