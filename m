Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVCaOlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVCaOlC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVCaOkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:40:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261470AbVCaOkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:40:40 -0500
Date: Thu, 31 Mar 2005 15:40:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [patch 03/12] uml: export getgid for hostfs
Message-ID: <20050331144026.GA18248@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Blaisorblade <blaisorblade@yahoo.it>,
	user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
	jdike@addtoit.com, linux-kernel@vger.kernel.org
References: <20050322162123.890086BA6F@zion> <200503240302.29153.blaisorblade@yahoo.it> <20050329114529.GA26005@infradead.org> <200503302005.26311.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503302005.26311.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 08:05:26PM +0200, Blaisorblade wrote:
> > My unaswered reply to the first submission is at
> >
> > http://groups-beta.google.com/group/linux.kernel/messages/de9504fe5963ccd1,
> >0c05294c599b22b1,eab26a4ed3f8ff17?thread_id=16c905c7e28e7498&mode=thread&noh
> >eader=1&q=uml-export-getgid-for-hostfs#doc_eab26a4ed3f8ff17
> >
> > (sorry, couldn't find it on marc), it's been Cc'ed to the lists you sent
> > the patch to.
> Sorry, I wasn't clear... I read *that* answer, but it says "as mentioned in 
> the discussion about ROOT_DEV", and I couldn't find it.

That'd be:

http://marc.theaimsgroup.com/?l=linux-fsdevel&m=110664428918937&w=2

> Also, I'd like to know whether there's a correct way to implement this (using 
> something different than root_dev, for instance the init[1] root directory 
> mount device). I understand that with the possibility for multiple mounts the 
> "root device" is more difficult to know (and maybe this is the reason for 
> which ROOT_DEV is bogus, is this?), but at least a check on the param 
> "rootfstype=hostfs" could be done.

personally I think it's a bad misfeature by itself.  If you absolutely
want it make it a mount option so it's explicit at least.

And yes, the only place where ROOT_DEV makes sense is in the early boot
process where the first filesystem in the first namespace is mounted, that's
why I want to get rid of the export to modules for it.

> Ok, this is nice. I'll repost the (updated) patch CC'ing Ingo Molnar (unless 
> there's another Ingo).

Yupp, mingo

