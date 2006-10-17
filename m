Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWJQS6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWJQS6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWJQS6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:58:30 -0400
Received: from web55615.mail.re4.yahoo.com ([206.190.58.239]:50085 "HELO
	web55615.mail.re4.yahoo.com") by vger.kernel.org with SMTP
	id S1750761AbWJQS63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:58:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wNNvjx0+aWZBPVVdtSiGxA6Irx3eWfQgFDh/nkvY5he619+gSZb+oriwL3UhFjJ4tcbEHiRGChXC1wfkuasQFXyhPs1rgUow5eeks47wNl3/u6nUsqKgReXniAeZ36PYkj2CwUUzWxvvCnLLwYudy8Va8/E7XLQUhC6ByEVnE/E=  ;
Message-ID: <20061017185828.82631.qmail@web55615.mail.re4.yahoo.com>
Date: Tue, 17 Oct 2006 11:58:28 -0700 (PDT)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: potential mem leak when system is low on memory
To: Jarek Poplawski <jarkao2@o2.pl>, Amit Choudhary <amit2030@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061017081020.GB1742@ff.dom.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > func()
> > {
> >    for (i = 0; i < LENGTH; i++) {
> >            var1[i] = kmalloc(size);
> >            if (!var1[i])
> >                 return -ENOMEM;
> > 
> > /* mem leak as var1[0] to var1[i - 1] is not freed */
> > 
> >    }
> > }
> > 
> > So, already the system is running low on memory and on top of it there
> > are leaks.
> 
> So you've found elementary programming bugs and it would
> be nice to point this places.
> 

As of now, when I come across such a leak, I fix it. But if I am unable to do so, I will
definitely send out a mail.

Regards,
Amit Choudhary
 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
