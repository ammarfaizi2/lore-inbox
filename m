Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWIUAsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWIUAsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWIUAsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:48:18 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:37534 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750882AbWIUAsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:48:16 -0400
Date: Thu, 21 Sep 2006 09:51:00 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lhms-devel@lists.sourceforge.net, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       pj@sgi.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [Lhms-devel] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060921095100.25e02b5c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0609201629220.1859@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773208.8574.53.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	<1158775678.8574.81.camel@galaxy.corp.google.com>
	<20060920155815.33b03991.pj@sgi.com>
	<1158794808.7207.14.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201629220.1859@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 16:31:22 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Wed, 20 Sep 2006, Rohit Seth wrote:
> 
> > Absolutely.  Since these containers are not (hard) partitioning the
> > memory in any way so it is easy to change the limits (effectively
> > reducing and increasing the memory limits for tasks belonging to
> > containers).  As you said, memory hot-un-plug is important and it is
> > non-trivial amount of work.
> 
> Maybe the hotplug guys want to contribute to the discussion?
> 
Ah, I'm reading threads with interest.

I think this discussion is about using fake nodes ('struct pgdat')
to divide system's memory into some chunks. Your thought is that
for resizing/adding/removing fake pgdat, memory-hot-plug codes may be useful. 
correct ?

Now, memory-hotplug manages all memory by 'section' and allows adding/(removing)
section to pgdat.
Does this section-size handling meet container people's requirement ?
And do we need freeing page when pgdat is removed ?

I think at least SPARSEMEM is useful for fake nodes because 'struct page'
are not tied to pgdat. (DISCONTIGMEM uses node_start_pfn. SPARSEMEM not.)

-Kame

