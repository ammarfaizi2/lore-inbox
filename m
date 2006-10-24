Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWJXCnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWJXCnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 22:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWJXCns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 22:43:48 -0400
Received: from web32414.mail.mud.yahoo.com ([68.142.207.207]:25751 "HELO
	web32414.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030195AbWJXCns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 22:43:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=k0MkW2LSbX/Y1+DpVOIcECK7nGZwkRsRI82o2/xBf7npx510dafgqJCOncRNyFegQeDceBIqCCejEreDsWeD7EOssQYS/Mju4xCxXSNQkGsFroE2hTmAuADNc+uWfjyyGOTQvfQZvA3fin9qZa2BQOqp1Q3J21VOS80Oh+DhRBQ=  ;
Message-ID: <20061024024347.57840.qmail@web32414.mail.mud.yahoo.com>
Date: Mon, 23 Oct 2006 19:43:47 -0700 (PDT)
From: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: incorrect taint of ndiswrapper
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161608452.19388.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Taint is used to identify situations where debug data may not be good,
> that may be proprietary or other dubiously legal code, it may be forcing
> SMP active on non SMP suitable systems, it may be overriding certain
> options in a potentially hazardous fashion. Taint exists primarily to
> help debugging data analysis.

I have read the history of the patch that marked ndiswrapper as "proprietary
module", which is not correct (and that was the point of my original post).
All the posts realted to this referred to issues with loading binary code
into kernel (and since ndiswrapper does taint the kernel when a driver is
loaded, this again is misplaced).

> EXPORT_SYMBOL_GPL() is used to assert that the symbol is absolutely
> definitely not a public symbol. EXPORT_SYMBOL exports symbols which
> might be but even then the GPL derivative work rules apply. When you
> mark a driver GPL it is permitted to use _GPL symbols, but if it does so
> it cannot then go and load other non GPL symbols and expect people not
> to question its validity.

I was not fully aware of this issue until now (I have read posts related to
this issue now). Does this mean that any module that loads binary code can't
be GPL, even those that load firmware files? How is
non-GPL-due-to-transitivity going to be checked? Why does module loader mark
only couple of modules as non-GPL, when there are other drivers that load
some sort of binary code? It is understandable to mark a module as non-GPL if
it is lying about its license, but as far as that is concerned, ndiswrapper
(alone) is GPL.

Thanks,
Giri

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
