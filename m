Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317672AbSGaDMN>; Tue, 30 Jul 2002 23:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317674AbSGaDMN>; Tue, 30 Jul 2002 23:12:13 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49933 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317672AbSGaDMM>; Tue, 30 Jul 2002 23:12:12 -0400
Date: Tue, 30 Jul 2002 23:08:19 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Theurer <habanero@us.ibm.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
In-Reply-To: <20020730000912.GA6406@714-cm.cps.unizar.es>
Message-ID: <Pine.LNX.3.96.1020730230654.6974E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, J.A. Magallon wrote:

> How about this version (gcc-3.2 generates the same amount of assembler):

Now *that* is readable code!
 
> int find(int this_cpu)
> {
>     int i;
> 
>     for (   i = (this_cpu+1)%smp_num_cpus;
>             i != this_cpu;
>             i = (i+1)%smp_num_cpus  )
>     {
>         int physical = cpu_logical_map(i);
>         int sibling = cpu_sibling_map[physical];
> 
>         if (idle_cpu(physical) && idle_cpu(sibling))
>             return physical;
>     }
>     return -1;
> }

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

