Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUCUR7l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 12:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbUCUR7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 12:59:41 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:54924 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263695AbUCUR7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 12:59:39 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Mar 2004 09:59:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
In-Reply-To: <20040321125730.GB21844@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004, Jörn Engel wrote:

> On Sat, 20 March 2004 08:48:43 -0800, Davide Libenzi wrote:
> > 
> > FWIW I did this quite some time ago to speed up copy+diff linux kernel 
> > trees:
> > 
> > http://www.xmailserver.org/flcow.html
> > 
> > It is entirely userspace and uses LD_PRELOAD on my dev shell.
> 
> Nice work.  I was thinking about something like that as an
> intermediate solution (my goal is libc inclusion), just with slightly
> different checks:
> 
> 	int ret = open(...);
> 	if (ret == -EMLINK)
> 		ret = cow_open(...);
> 	return ret;

When I did that, fumes of an in-kernel implementation invaded my head for 
a little while. Then you start thinking that you have to teach apps of new 
open(2) semantics, you have to bloat kernel code a little bit and you have 
to deal with a new set of errors cases that open(2) is not expected to 
deal with. A fully userspace implementation did fit my needs at that time, 
even if the LD_PRELOAD trick might break if weak aliases setup for open 
functions change inside glibc.



- Davide


