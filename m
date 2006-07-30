Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWG3CQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWG3CQS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 22:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWG3CQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 22:16:18 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:51420 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751061AbWG3CQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 22:16:17 -0400
Date: Sun, 30 Jul 2006 11:17:47 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, kmannth@us.ibm.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, akpm@osdl.org, haveblue@us.ibm.com,
       darnok@us.ibm.com
Subject: Re: [discuss] [Patch] 2/5 in support of hot-add memory x86_64
 create arch_find_node
Message-Id: <20060730111747.6554f7de.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200607291825.16308.ak@suse.de>
References: <1154141545.5874.146.camel@keithlap>
	<200607291825.16308.ak@suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2006 18:25:15 +0200
Andi Kleen <ak@suse.de> wrote:

> On Saturday 29 July 2006 04:52, keith mannthey wrote:
> >   With the advent of the new ACPI hot-plug memory driver and mechanism
> > is needed to deal with ACPI add memory events that do not contain the
> > pxm (node) information. I do not believe that the add-event is required
> > to contain this information so I create a arch_find_node generic layer
> > used in the generic add_memory function.
> >
> >   If add_memory is called with node < 0 arch_find_node is invoked to
> > fine the correct node to add the memory. This created the generic
> > construct of arch_find_node.
> 
> It would be cleaner to always call add_memory from architecture specific
> code instead of such ugly hooks
> 
Hi,  Keith 

I don't like insert such a check (nid < 0) in add_memory(), either.
Could you add it before calling add_memory() ?
(for example, find_pxm parh in acpi's add memory code.)

-Kame

