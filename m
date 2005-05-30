Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVE3SjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVE3SjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVE3SjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:39:10 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:35986 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261644AbVE3Six
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:38:53 -0400
Date: Mon, 30 May 2005 20:37:51 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kus Kusche Klaus <kus@keba.com>, James Bruce <bruce@andrew.cmu.edu>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <429B0003.5060803@yahoo.com.au>
Message-Id: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Nick Piggin wrote:

> Esben Nielsen wrote:
> 
> > I do like the idea of guest kernels - especially the ability to enforce a
> > strict seperation of RT and non-RT. But you can't use _any_ part of the
> > Linux kernel in your RT application - not even drivers. I know a lot of
> 
> If you can't use the drivers, then presumably they're no good
> to be used as they are for realtime in Linux either, though :(
>
The driver is probably good enough but because you have to call into the
Linux kernel to use them. With a guest kernel setup  you can forget about
realtime then. With PREEMPT_RT you get hard realtime behaviour out of the
box.

Ofcourse, there is a lot of buts to that. You have to check that the
driver doesn't take a call path which is nontermnistic in special cases
and the path between your application and the driver is deterministic.
A static code checker would be nice...

Esben

