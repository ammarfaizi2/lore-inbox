Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUFHJHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUFHJHh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbUFHJHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:07:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264912AbUFHJHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:07:34 -0400
Date: Tue, 8 Jun 2004 05:07:12 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, arjanv@redhat.com, luto@myrealbox.com,
       mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@osdl.org,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040608090712.GW4736@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604154142.GF16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org> <20040604155138.GG16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org> <20040604181304.325000cb.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604181304.325000cb.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 06:13:04PM +0200, Andi Kleen wrote:
> Of course that is only for the stack. Making the heap non executable
> is another can of worms. I don't know if Fedora does that
> too, SUSE and mainline x86-64 doesn't.

When I added PT_GNU_STACK, it was meant from the beginning as
stack+heap+mmap w/o PROT_EXEC executability/non-executability.
I don't think it makes any sense to have separate bits for heap and stack.
Any program which assumes PROT_READ implies PROT_EXEC just can be marked
PT_GNU_STACK PF_X.

	Jakub
