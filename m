Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUJEKCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUJEKCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 06:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUJEKCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 06:02:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:40608 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268899AbUJEKCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 06:02:10 -0400
Date: Tue, 5 Oct 2004 02:58:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: mbligh@aracnet.com, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041005025850.68435783.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> But now I see that the discussion is going towards:
> -fully exclusive cpusets, maybe even with no interrupts handling
> -maybe only allow exclusive cpusets, since non-exclusive cpusets are 
> tricky wrt CKRM.
> 
> That would be a no-go for us.

I'm with you there, Simon.  Not all cpusets should be exclusive.

It is reasonable for domain-capable schedulers, allocators and
resource managers (domain aware CKRM?) require that any domain
they manage correspond to an exclusive cpuset, for some value
of exclusive stronger than now.

Less exclusive cpusets just wouldn't qualify for their own
scheduler, allocator or resource manager domains.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
