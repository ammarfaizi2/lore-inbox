Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266179AbUG0QCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUG0QCC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUG0QCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:02:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:49347 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266179AbUG0QAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:00:19 -0400
Date: Tue, 27 Jul 2004 17:57:13 +0200
From: Andi Kleen <ak@suse.de>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: colpatch@us.ibm.com, jbarnes@sgi.com, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net
Subject: Re: [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Message-Id: <20040727175713.10a95ad6.ak@suse.de>
In-Reply-To: <200407270815.39165.jbarnes@engr.sgi.com>
References: <1090887007.16676.18.camel@arrakis>
	<20040727161628.56a03aec.ak@suse.de>
	<200407270815.39165.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 08:15:39 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Tuesday, July 27, 2004 7:16 am, Andi Kleen wrote:
> > On Mon, 26 Jul 2004 17:10:08 -0700
> >
> > Matthew Dobson <colpatch@us.ibm.com> wrote:
> > > So in discussions with Jesse at OLS, we decided that pcibus_to_node() is
> > > a more generally useful function than pcibus_to_cpumask().  If anyone
> > > disagrees with that, now would be a good time to let us know.
> >
> > Not sure that is a good idea. Sometimes this information is not available.
> > With pcibus_to_cpumask() the fallback is obvious, but it isn't with
> > pcibus_to_node(). Returning a random node is wrong.
> 
> Hmm... so there's no way for you to get a node or nodemask at all?

When the BIOS has _PXM methods there will be probably.
Just I cannot guarantee it has that, so there should be some clean fallback path.

If cpumask is too complicated for you a pcibus_to_nodemask would be fine
for me too, just please no single node number.


-Andi
