Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUFHJO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUFHJO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUFHJO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:14:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:52139 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262009AbUFHJO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:14:56 -0400
Date: Tue, 8 Jun 2004 11:14:53 +0200
From: Andi Kleen <ak@suse.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: torvalds@osdl.org, arjanv@redhat.com, luto@myrealbox.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, akpm@osdl.org, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
 2.6.7-rc2-bk2
Message-Id: <20040608111453.22cae15a.ak@suse.de>
In-Reply-To: <20040608090712.GW4736@devserv.devel.redhat.com>
References: <20040602205025.GA21555@elte.hu>
	<20040603230834.GF868@wotan.suse.de>
	<20040604092552.GA11034@elte.hu>
	<200406040826.15427.luto@myrealbox.com>
	<Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
	<20040604154142.GF16897@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
	<20040604155138.GG16897@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
	<20040604181304.325000cb.ak@suse.de>
	<20040608090712.GW4736@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004 05:07:12 -0400
Jakub Jelinek <jakub@redhat.com> wrote:

> On Fri, Jun 04, 2004 at 06:13:04PM +0200, Andi Kleen wrote:
> > Of course that is only for the stack. Making the heap non executable
> > is another can of worms. I don't know if Fedora does that
> > too, SUSE and mainline x86-64 doesn't.
> 
> When I added PT_GNU_STACK, it was meant from the beginning as
> stack+heap+mmap w/o PROT_EXEC executability/non-executability.
> I don't think it makes any sense to have separate bits for heap and stack.
> Any program which assumes PROT_READ implies PROT_EXEC just can be marked
> PT_GNU_STACK PF_X.

heap execution seems to be a lot more common than stack execution.

-Andi
