Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbVCXCDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVCXCDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 21:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVCXCDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 21:03:25 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:4702 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262982AbVCXCDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 21:03:08 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 03/12] uml: export getgid for hostfs
Date: Thu, 24 Mar 2005 03:02:28 +0100
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050322162123.890086BA6F@zion> <20050322181140.GA22149@infradead.org>
In-Reply-To: <20050322181140.GA22149@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503240302.29153.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2005 19:11, Christoph Hellwig wrote:
> On Tue, Mar 22, 2005 at 05:21:23PM +0100, blaisorblade@yahoo.it wrote:
> > Export this symbol which is not satisfied currently. The code using it
> > has been merged, so please export this symbol.

> and it's still bogus, and you haven't replied when I mentioned it last
> time.
In this moment I need to clean up the missing symbol. If anyone wants to 
remove the code using this, then he might post a patch explictly removing it, 
and getting it refused probably.

Or at least CC uml-devel when discussing those problems. I'm not currently 
able to find on marc.theaimsgroup.com the mail you talk about. Can you please 
provide the URL to the discussion? (even on any other archive you like, 
obviously).

That said, there are people still using that code, so it should be kept in.

Also, you blocked an important patch (the one adding ->release to 
hw_interrupt_type) saying that *perhaps* UML should avoid having any hard 
irq, a la S390. You forced so the merge of a very ugly patch manually calling 
what should have been UML's release method (i.e. free_irq_by_irq_and_dev) in 
every place calling free_irq() (and in fact one was missed at first). Might 
you reconsider your position on that issue ? (URL of the discussion below)

http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=3&s=uml+irq&q=b

The patch adding the generic handling is this one:

http://marc.theaimsgroup.com/?l=linux-kernel&m=109834481320519&w=2

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

