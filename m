Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUCLUSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbUCLUQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:16:38 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:14854 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S262368AbUCLUIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:08:38 -0500
Date: Fri, 12 Mar 2004 15:08:33 -0500
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Andreas Dilger
	 =?us-ascii?B?PD0/Q1AgMTI1Mj9xP2FkaWxnZXI9NDBjbHVzdGVy?=
	 =?us-ascii?B?ZnM9MkVjb20/PT4gPT9DUA==?=
	 1252?q?=2CS=F8ren=20Hansen?= <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UID/GID mapping system
Message-ID: <20040312200833.GC24074@fieldses.org>
References: <1078775149.23059.25.camel@luke> <04031108083100.05054@tabby> <20040311160245.GB18466@fieldses.org> <04031207583301.07660@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04031207583301.07660@tabby>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 07:58:33AM -0600, Jesse Pollard wrote:
> Not really - it would be a 1:1 map... so what would be the purpose?

Are you asking what would be the purpose of client-side mapping?

So, in the worst case you have a laptop that you want to be able to
simultaneously mount one NFS server maintained by organization X, and
another maintained by organization Y.  But unfortunately you have
different uid's in X and Y.  (Given sufficiently large independent
organizations X and Y this is inevitable and unfixable.)  What do you
do?

> The problem is in the audit - the server would report a violation in
> uid xxx. Which according to it's records is not used on the penetrated client
> (at least not via the filesystem). Yet the administrator would report that the
> uid is valid (because of a bogus local map).

I don't understand your description of the problem; could you be more
specific?  E.g., what do you mean by "a violation in uid xxx"?

In general if your server trusts clients to get uid's right, and if
users already have sufficient control over the client to tell the kernel
to remap uid's, then they can already lie to the server about their uid.
(It probably happens every now and then already just by mistake; e.g. if
people are throwing a linux distribution on their personal laptop and
expecting to be able to mount the nfsd server there's a good chance
they'll forget to give themselves the right uid from the start.)

--Bruce Fields
