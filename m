Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWFRGng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWFRGng (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 02:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWFRGnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 02:43:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932108AbWFRGnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 02:43:35 -0400
Date: Sat, 17 Jun 2006 23:42:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: sam@vilain.net, vatsa@in.ibm.com, dev@openvz.org, efault@gmx.de,
       mingo@elte.hu, pwil3058@bigpond.net.au, sekharan@us.ibm.com,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       maeda.naoaki@jp.fujitsu.com, kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
Message-Id: <20060617234259.dc34a20c.akpm@osdl.org>
In-Reply-To: <4494EE86.7090209@yahoo.com.au>
References: <20060615134632.GA22033@in.ibm.com>
	<4493C1D1.4020801@yahoo.com.au>
	<20060617164812.GB4643@in.ibm.com>
	<4494DF50.2070509@yahoo.com.au>
	<4494EA66.8030305@vilain.net>
	<4494EE86.7090209@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006 16:11:18 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> If you want to *completely* isolate N groups of users, surely you
> have to use virtualisation,

I'd view this as a kludge.  If one group of tasks is trashing the
performance of another group of tasks the user is forced to use hardware
virtualisation to work around it.

I mean, is this our answer to the updatedb problem?  Instantiate a separate
copy of the kernel just to run updatedb?

> unless you are willing to isolate memory
> management, pagecache, slab caches, network and disk IO, etc.

Well yes.  Ideally and ultimately.  People have done this, and it's in
production.  We need to see (and work upon) the patches before we can judge
whether we want to do this, and how far we want to go.

> Again, I don't care about the solutions at this stage. I want to know
> what the problem is. Please?

Isolation.  To prevent one group of processes from damaging the performance
of other groups, by providing manageability of the resource consumption of
each group.  There are plenty of applications of this, not just
server-consolidation-via-server-virtualisation.

