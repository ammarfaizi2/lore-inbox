Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWCaXiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWCaXiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWCaXiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:38:46 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:18580 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1751446AbWCaXip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:38:45 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Date: Fri, 31 Mar 2006 15:38:24 -0800
User-Agent: KMail/1.9.1
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, bcasavan@sgi.com,
       Keith Owens <kaos@sgi.com>, Andi Kleen <ak@suse.de>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
References: <20051213162027.GA14158@us.ibm.com> <20060313183932.GE1297@us.ibm.com> <20060331045627.GB426545@sgi.com>
In-Reply-To: <20060331045627.GB426545@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311538.24851.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Unknown author]
> > > From comments by jejb, we're looking at modifying the mmiowb
> > > API by adding an argument which would be a register to read
> > > from if the architecture in question needs ordering in this
> > > way but does not have a lighter weight mechanism like the Altix
> > > mmiowb.  Since there will now need to be a width indication,
> > > mmiowb will be replaced with mmiowb[bwlq].
> >
> > Any progress on this front?  I figured that I would wait to update
> > the ordering document until after this change happened, but if it
> > is going to be awhile, I should proceed with the current API.

I avoided doing this initially on the premise that I shouldn't do things 
'just because we might need it in the future' since that way seems to 
lead to madness.  Is there actual hardware that needs an argument to 
mmiowb() (i.e. that can't just do a read from the system's single bridge 
or something)?

Jesse
