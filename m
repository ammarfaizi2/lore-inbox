Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVJBX0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVJBX0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVJBX0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:26:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751091AbVJBX0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:26:24 -0400
Date: Sun, 2 Oct 2005 19:26:21 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051002230545.GI6290@lkcl.net>
Message-ID: <Pine.LNX.4.63.0510021922290.27456@cuia.boston.redhat.com>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
 <20051002230545.GI6290@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:
> On Sun, Oct 02, 2005 at 05:05:42PM -0400, Rik van Riel wrote:

> > Linux already has a number of scalable SMP synchronisation
> > mechanisms. 
> 
>  ... and you are tied in to the decisions made by the linux kernel
>  developers.
> 
>  whereas, if you allow something like a message-passing design (such as
>  in the port of the linux kernel to l4), you have the option to try out
>  different underlying structures - _without_ having to totally redesign
>  the infrastructure.

Infrastructure is not what matters when it comes to SMP
scalability on modern systems, since lock contention is
not the primary SMP scalability problem.

Due to the large latency ratio between L1/L2 cache and
RAM, the biggest scalability problem is cache invalidation
and cache bounces.

Those are not solvable by using another underlying
infrastructure - they require a reorganization of the
datastructures on top, the data structures in Linux.

Note that message passing is by definition less efficient
than SMP synchronisation mechanisms that do not require
data to be exchanged between CPUs, eg. RCU or the use of
cpu-local data structures.

>  p.s. yes i do know of a company that has improved on SMP.

SGI ?  IBM ?

-- 
All Rights Reversed
