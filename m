Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263355AbUJ2OZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUJ2OZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbUJ2OXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:23:07 -0400
Received: from pat.uio.no ([129.240.130.16]:42400 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263336AbUJ2OUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:20:41 -0400
Subject: Re: How to safely reduce stack usage in nfs code?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1099040501.2641.9.camel@laptop.fenrus.org>
References: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099040501.2641.9.camel@laptop.fenrus.org>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 10:20:25 -0400
Message-Id: <1099059626.11099.10.camel@dh138.citi.umich.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 29.10.2004 Klokka 11:01 (+0200) skreiv Arjan van de Ven:
> On Fri, 2004-10-29 at 00:20 +0300, Denis Vlasenko wrote:
> 
> > I can convert these into kmalloc'ed variants but hesitate to do so
> > because of possible 'need to kmalloc in order to free memory for kmalloc'
> > deadlocks.
> 
> how about a memory pool?
> 
> It's not THE solution but I suspect the depth of callchains of these isn't too deep so it would work

I can't see that any of the callchains Denis listed can deadlock. None
of them appear to lie in the memory reclaim paths.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

