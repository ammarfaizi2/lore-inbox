Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSG2UJs>; Mon, 29 Jul 2002 16:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318066AbSG2UJs>; Mon, 29 Jul 2002 16:09:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23035 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317892AbSG2UJr>; Mon, 29 Jul 2002 16:09:47 -0400
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200207291454.30076.habanero@us.ibm.com>
References: <200207291454.30076.habanero@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 22:28:42 +0100
Message-Id: <1027978122.4050.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 20:54, Andrew Theurer wrote:
> I would caution against having hyperthreading on by default in the 2.4.19 
> release.  I am seeing a significant degrade in network workloads on P4 with 
> hyperthreading on.  On 2.4.19-pre10, I get 788 Mbps on NetBench, but on 
> 2.4.19-rc1 (and probably rc3, should know in an hour), I get 690 Mbps.  It is 
> clearly a hyperthreading/interrupt routing issue.  On this system (4 x P4), 

Quite possibly. I've just merged the O(1) scheduler load balancing fixes
for the hyperthreading stuff, rc3 uses the old scheduler so that isnt
your problem. For most workloads I see a speed up. The more cache
optimised the workload the less the speedup.

Its quite possible the irq routing ought to be smarter, at the moment
I'm not sure of the best approaches.

