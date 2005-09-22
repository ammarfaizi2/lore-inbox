Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVIVToZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVIVToZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVIVToZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:44:25 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:32111 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030187AbVIVToY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:44:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=CcOVlwrJjdA1auN9Fjhs9J5RZIXM6ZwM0QR3qwz47VWXppr6Ftkr5iIM+DIUIwUykpljDoq6ybj5atrwC8YvjgeX6nFKjbqXbSFkG3tIIQZGUUt46anaxL4X48L39YxnbuGOr0P5fsGvqLOlfcSe+u+h64E881LUBzn1TTtgVZs=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 06/10] uml: run mconsole "sysrq" in process context
Date: Thu, 22 Sep 2005 21:20:20 +0200
User-Agent: KMail/1.8.2
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200509211923.21861.blaisorblade@yahoo.it> <20050921172857.10219.71071.stgit@zion.home.lan> <20050921205028.GB9918@ccure.user-mode-linux.org>
In-Reply-To: <20050921205028.GB9918@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509222120.20922.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 22:50, Jeff Dike wrote:
> On Wed, Sep 21, 2005 at 07:28:57PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Things are breaking horribly with sysrq called in interrupt context. I
> > want to try to fix it, but probably this is simpler. To tell the truth,
> > sysrq is normally run in interrupt context, so there shouldn't be any
> > problem.
>
> How are they breaking?
sysrq t is broken (and stays), but additionally there are some warnings from 
some commands (enable sleep inside spinlock checking and spinlock debugging), 
which go to the down_read inside handle_page_fault IIRC. So try to run in 
process context.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
