Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVIHByK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVIHByK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVIHByK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:54:10 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:40027 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932500AbVIHByJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:54:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UTxK4s1QDZ5ngYIxvv+M8CWEZAD3acd+myO9ehPgX5PcSzeA01NWRIxLTvoVlwB1gHnWxuet2ENdSqRLF9MYi98WS1ov+luLjMoWNGOLu5Ocvl7ZiXJ6HdnWIRtQ/Sa9loWwQ+XDnZfSMOiSFPOfB2PPV5x3FXc8mv+VsjEsf0E=
Message-ID: <aec7e5c305090718543e2ff047@mail.gmail.com>
Date: Thu, 8 Sep 2005 10:54:08 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: magnus.damm@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, haveblue@us.ibm.com,
       magnus@valinux.co.jp, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       andyw@uk.ibm.com
In-Reply-To: <20050907164945.14aba736.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050906035531.31603.46449.sendpatchset@cherry.local>
	 <1126114116.7329.16.camel@localhost> <512850000.1126117362@flay>
	 <1126117674.7329.27.camel@localhost> <521510000.1126118091@flay>
	 <20050907164945.14aba736.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Andrew Morton <akpm@osdl.org> wrote:
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> >
> >
> >
> > --On Wednesday, September 07, 2005 11:27:54 -0700 Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> > > On Wed, 2005-09-07 at 11:22 -0700, Martin J. Bligh wrote:
> > >> CONFIG_NUMA was meant to (and did at one point) support both NUMA and flat
> > >> machines. This is essential in order for the distros to support it - same
> > >> will go for sparsemem.
> > >
> > > That's a different issue.  The current code works if you boot a NUMA=y
> > > SPARSEMEM=y machine with a single node.  The current Kconfig options
> > > also enforce that SPARSEMEM depends on NUMA on i386.
> > >
> > > Magnus would like to enable SPARSEMEM=y while CONFIG_NUMA=n.  That
> > > requires some Kconfig changes, as well as an extra memory present call.
> > > I'm questioning why we need to do that when we could never do
> > > DISCONTIG=y while NUMA=n on i386.
> >
> > Ah, OK - makes more sense. However, some machines do have large holes
> > in e820 map setups - is not really critical, more of an efficiency
> > thing.
> 
> Confused.   Does all this mean that we want the patch, or not?

What about if I remove the Kconfig stuff and just keep the "fix" for
the non-NUMA version of setup_memory()?

/ magnus
