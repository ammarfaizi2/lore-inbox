Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264197AbUE1W1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbUE1W1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUE1WYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:24:19 -0400
Received: from hera.kernel.org ([63.209.29.2]:52122 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264174AbUE1WVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:21:03 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Don't return void types from void functions.
Date: Fri, 28 May 2004 22:20:11 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c98dur$pd5$1@terminus.zytor.com>
References: <200405260606.i4Q66dXB023475@hera.kernel.org> <40B43913.7010207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1085782811 26022 127.0.0.1 (28 May 2004 22:20:11 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 28 May 2004 22:20:11 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <40B43913.7010207@pobox.com>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
>
> Linux Kernel Mailing List wrote:
> > diff -Nru a/drivers/net/tokenring/olympic.c b/drivers/net/tokenring/olympic.c
> > --- a/drivers/net/tokenring/olympic.c	2004-05-25 23:06:49 -07:00
> > +++ b/drivers/net/tokenring/olympic.c	2004-05-25 23:06:49 -07:00
> > @@ -1806,7 +1806,7 @@
> >  
> >  static void __exit olympic_pci_cleanup(void)
> >  {
> > -	return pci_unregister_driver(&olympic_driver) ; 
> > +	pci_unregister_driver(&olympic_driver) ; 
> >  }	
> 
> 
> Can we make gcc error out when it finds this?
> 

What's wrong with it?  Seriously... "return foo();" is the closest
thing to a tailcall syntax as C/C++ has, and I've always considered it
a Total Fscking Pain in The Ass[TM] that it somehow thinks functions
returning void should have a different syntax than all other functions.

	-hpa
