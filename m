Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318638AbSIFO0f>; Fri, 6 Sep 2002 10:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSIFO0f>; Fri, 6 Sep 2002 10:26:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40636 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318638AbSIFO0e>; Fri, 6 Sep 2002 10:26:34 -0400
Date: Fri, 06 Sep 2002 07:29:21 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
cc: hadi@cyberus.ca, tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <46202575.1031297360@[10.10.2.3]>
In-Reply-To: <20020905.235159.128049953.davem@redhat.com>
References: <20020905.235159.128049953.davem@redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stupid question, are you sure you have CONFIG_E1000_NAPI enabled?
> 
> NAPI is also not the panacea to all problems in the world.

No, but I didn't expect throughput to drop by 40% or so either,
which is (very roughly) what happened. Interrupts are a pain to
manage and do affinity with, so NAPI should (at least in theory)
be better for this kind of setup ... I think.
 
> I bet your greatest gain would be obtained from going to Tux
> and using appropriate IRQ affinity settings and making sure
> Tux threads bind to same cpu as device where they accept
> connections.
> 
> It is standard method to obtain peak specweb performance.

Ah, but that's not really our goal - what we're trying to do is
use specweb as a tool to simulate a semi-realistic customer
workload, and improve the Linux kernel performance, using that
as our yardstick for measuring ourselves. For that I like the
setup we have reasonably well, even though it won't get us the
best numbers.

To get the best benchmark numbers, you're absolutely right though.

M.

