Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVLLVLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVLLVLq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVLLVLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:11:46 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:16660 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751280AbVLLVLp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:11:45 -0500
Subject: Re: Kernel BUG at arch/x86_64/mm/pageattr.c:154
From: Kasper Sandberg <lkml@metanurb.dk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1134407505.2874.21.camel@laptopd505.fenrus.org>
References: <1134406398.4953.3.camel@localhost>
	 <1134407505.2874.21.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 22:11:28 +0100
Message-Id: <1134421888.9370.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 18:11 +0100, Arjan van de Ven wrote:
> On Mon, 2005-12-12 at 17:53 +0100, Kasper Sandberg wrote:
> > hello... i know my kernel is tainted,
> 
> ...
> 
> > Call Trace:<ffffffff80101810>{init_level4_pgt+2064}
> > <ffffffff8011e31b>{change_page_attr_addr+155}
> >        <ffffffff88479947>{:nvidia:nv_vm_free_pages+274}
> > <ffffffff88475b44>{:nvidia:nv_kern_vma_release+126}
> >        <ffffffff8015f80c>{remove_vma+44} <ffffffff8015fd78>{exit_mmap
> > +184}
> >        <ffffffff8012c37b>{mmput+27} <ffffffff80130633>{do_exit+547}
> >        <ffffffff80131029>{do_group_exit+169}
> > <ffffffff8010e96e>{system_call+126}
> 
> ... and the nvidia module is all over the backtrace. I think this is a
> clear one for reporting to nvidia instead....
okay, i just thought it was relevant to post here, since the warnings
came after the changes which made nvidia complain.. and since linus was
interrested in that i figured i might aswell post this
> 
> 

