Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUH1Bf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUH1Bf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUH1Bf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:35:29 -0400
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:3473 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S266096AbUH1BfW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:35:22 -0400
Date: Fri, 27 Aug 2004 17:33:59 -0800 (AKDT)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       erikj@dbear.engr.sgi.com, limin@engr.sgi.com,
       lse-tech@lists.sourceforge.net,
       =?X-UNKNOWN?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>
Subject: Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <20040827054218.GA4142@frec.bull.fr>
Message-ID: <Pine.LNX.4.58.0408271728590.1075@bifrost.nevaeh-linux.org>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
 <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de>
 <20040827054218.GA4142@frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -1.971 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Guillaume Thouvenin wrote:

> I like this solution.
> In fact what I proposed was to have PAGG and a modified BSD accounting
> that can be used with PAGG as both are already in the -mm tree. But
> manage group of processes from userspace is, IMHO, a better solution as
> modifications in the kernel will be minimal.
>
>   Therefore the solution could be to enhance BSD accounting with data
> collection from CSA and provide per job accounting with a userspace
> mechanism. Sounds great to me...

The only concern I have with a userspace solution is that you run the risk of
losing that data.  What happens if a process on the box drives drives it out
of memory and paging space?  The box would still be working, it just wouldn't
be able to fork new processes, and those already running that aren't purposely
made high priority may not get much of a chance to execute as well.  I've lost
SAR data that way.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
