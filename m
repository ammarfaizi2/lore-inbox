Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUCORSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbUCORSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:18:00 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:14319 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262712AbUCORR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:17:57 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: UID/GID mapping system
Date: Mon, 15 Mar 2004 11:17:43 -0600
X-Mailer: KMail [version 1.2]
Cc: "Andreas Dilger <adilger@cluster fs.com> =?CP
	1252?q?=2CS=F8ren=20Hansen?=" <sh@warma.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1078775149.23059.25.camel@luke> <04031207583301.07660@tabby> <20040312200833.GC24074@fieldses.org>
In-Reply-To: <20040312200833.GC24074@fieldses.org>
MIME-Version: 1.0
Message-Id: <04031511174301.13518@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 March 2004 14:08, J. Bruce Fields wrote:
> On Fri, Mar 12, 2004 at 07:58:33AM -0600, Jesse Pollard wrote:
> > Not really - it would be a 1:1 map... so what would be the purpose?
>
> Are you asking what would be the purpose of client-side mapping?
>
> So, in the worst case you have a laptop that you want to be able to
> simultaneously mount one NFS server maintained by organization X, and
> another maintained by organization Y.  But unfortunately you have
> different uid's in X and Y.  (Given sufficiently large independent
> organizations X and Y this is inevitable and unfixable.)  What do you
> do?

The server maps the valid uid to the uid used on the client.

Obviously the client is not under the control of the server security domain.

> > The problem is in the audit - the server would report a violation in
> > uid xxx. Which according to it's records is not used on the penetrated
> > client (at least not via the filesystem). Yet the administrator would
> > report that the uid is valid (because of a bogus local map).
>
> I don't understand your description of the problem; could you be more
> specific?  E.g., what do you mean by "a violation in uid xxx"?
>
> In general if your server trusts clients to get uid's right, and if
> users already have sufficient control over the client to tell the kernel
> to remap uid's, then they can already lie to the server about their uid.
> (It probably happens every now and then already just by mistake; e.g. if
> people are throwing a linux distribution on their personal laptop and
> expecting to be able to mount the nfsd server there's a good chance
> they'll forget to give themselves the right uid from the start.)

1. your first assumpion: "if your server trusts clients". The server
	should NOT trust a remote client.

2. "then they can already lie to the server about their uid" means the client
	is NOT under control and again should not be trusted.
