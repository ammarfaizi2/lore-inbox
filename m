Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268982AbUJELSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268982AbUJELSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268992AbUJELR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:17:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63193 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268982AbUJELRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:17:30 -0400
Date: Tue, 5 Oct 2004 07:17:09 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rui Nuno Capela <rncbc@rncbc.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T0
In-Reply-To: <32803.192.168.1.5.1096974670.squirrel@192.168.1.5>
Message-ID: <Pine.LNX.4.58.0410050714140.12457@devserv.devel.redhat.com>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> 
      <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>     
  <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>      
 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>      
 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>      
 <20041004215315.GA17707@elte.hu>       <Pine.LNX.4.58.0410050257400.5641@devserv.devel.redhat.com>
 <32803.192.168.1.5.1096974670.squirrel@192.168.1.5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Oct 2004, Rui Nuno Capela wrote:

> Unfortunately it doesn't seem to. Attached you may find some info I
> could dump out, as a snapshot of what I'm seeing on my fresh
> 2.6.9-rc3-mm2-T0.0smp kernel.

thanks. Do your problems go away if you turn off the SMT scheduler, or if
you disable SMP altogether on your P4-HT box?

> - top-100: top output, showing that ksoftirqd/1 is consuming 99.9% of one,
> but only one, of the virtual CPUs, permanentely.

i think this is the clearest indication that there's something is
fundamentally wrong - ksoftirqd must never use that much CPU time on an
idle system.

	Ingo
