Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318146AbSG3ASp>; Mon, 29 Jul 2002 20:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318151AbSG3ASp>; Mon, 29 Jul 2002 20:18:45 -0400
Received: from jalon.able.es ([212.97.163.2]:38386 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318146AbSG3ASo>;
	Mon, 29 Jul 2002 20:18:44 -0400
Date: Tue, 30 Jul 2002 02:21:06 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "J.A. Magallon" <jamagallon@able.es>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: oopsen with rc3-aa3
Message-ID: <20020730002106.GA1710@714-cm.cps.unizar.es>
References: <20020729174238.GA1919@714-cm.cps.unizar.es> <20020729181020.GU1201@dualathlon.random> <20020729223539.GA1936@714-cm.cps.unizar.es> <20020729224737.GJ1201@dualathlon.random> <20020729231203.GA6314@714-cm.cps.unizar.es> <20020729234433.GL1201@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020729234433.GL1201@dualathlon.random>; from andrea@suse.de on mar, jul 30, 2002 at 01:44:33 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20020730 Andrea Arcangeli wrote:
> On Tue, Jul 30, 2002 at 01:12:03AM +0200, J.A. Magallon wrote:
> > But -rc3-jam3 bombed on the dual-p4xeon box, but works on a PIII laptop.
> 
> I decored the oops and in short rq_target->idle is NULL, so then
> resched_task bugs out while reading p->need_resched.
> 
> it's the hyperthreading support that bugs out infact.
> 
> I had a look and this should fix it (the first one is just a theorical
> bug, since it's under an ifdef i386 cpu_number_map is an identity, the
> ++ thing was the reason I think). Can you test it?
> 

Thanks, I will try it tomorrow on the real box.

By
