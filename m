Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVC2Lq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVC2Lq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVC2Lq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:46:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:933 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262200AbVC2Lpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:45:50 -0500
Date: Tue, 29 Mar 2005 12:45:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 03/12] uml: export getgid for hostfs
Message-ID: <20050329114529.GA26005@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Blaisorblade <blaisorblade@yahoo.it>, akpm@osdl.org,
	jdike@addtoit.com, linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <20050322162123.890086BA6F@zion> <20050322181140.GA22149@infradead.org> <200503240302.29153.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503240302.29153.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 24, 2005 at 03:02:28AM +0100, Blaisorblade wrote:
> In this moment I need to clean up the missing symbol. If anyone wants to 
> remove the code using this, then he might post a patch explictly removing it, 
> and getting it refused probably.
> 
> Or at least CC uml-devel when discussing those problems. I'm not currently 
> able to find on marc.theaimsgroup.com the mail you talk about. Can you please 
> provide the URL to the discussion? (even on any other archive you like, 
> obviously).

My unaswered reply to the first submission is at

http://groups-beta.google.com/group/linux.kernel/messages/de9504fe5963ccd1,0c05294c599b22b1,eab26a4ed3f8ff17?thread_id=16c905c7e28e7498&mode=thread&noheader=1&q=uml-export-getgid-for-hostfs#doc_eab26a4ed3f8ff17

(sorry, couldn't find it on marc), it's been Cc'ed to the lists you sent
the patch to.

> That said, there are people still using that code, so it should be kept in.

But the code is totally bogus, so it should _not_ be kept.

> Also, you blocked an important patch (the one adding ->release to 
> hw_interrupt_type) saying that *perhaps* UML should avoid having any hard 
> irq, a la S390. You forced so the merge of a very ugly patch manually calling 
> what should have been UML's release method (i.e. free_irq_by_irq_and_dev) in 
> every place calling free_irq() (and in fact one was missed at first). Might 
> you reconsider your position on that issue ? (URL of the discussion below)
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=3&s=uml+irq&q=b
> 
> The patch adding the generic handling is this one:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109834481320519&w=2

I still think it's a really bad idea.  But I'm not the irq code maintainer,
it could very well be Ingo overrides me.
