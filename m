Return-Path: <linux-kernel-owner+w=401wt.eu-S965234AbXAGWnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbXAGWnV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbXAGWnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:43:21 -0500
Received: from web55613.mail.re4.yahoo.com ([206.190.58.237]:23457 "HELO
	web55613.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965234AbXAGWnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:43:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=XLKA8OEJYXMqXr7PqjYHgfScPZALciP9i64ZX1jQsBb6gSck6IsRODSQD2ewfg+kxj1Jn8TlKGdQtTCl17UnlatGufi7uYNNHrd3NUJihyhioGPgmkOQ6YVQ2RWl7xKXto83L7axsaMOnwxiaMmQV/bLiWc9si5kBSMCN6jZIVI=;
X-YMail-OSG: 8x5FrkoVM1l3esjHmdx7tTU5_2NjHQakCpCWfeMXUH91XgXah8hPmvOw2eVtdO31.uipmEHk0dcbkjkXw328w3Z_FtI37sJ_t2tWoyeC.zoMlY2mikFp2H0zlYxxGyQFKn4Ezof8MQ_53lg-
Date: Sun, 7 Jan 2007 14:43:20 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20070107102427.GA26849@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <108973.65122.qm@web55613.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Christoph Hellwig <hch@infradead.org> wrote:

> On Sun, Jan 07, 2007 at 12:46:50AM -0800, Amit Choudhary wrote:
> > Well, I am not proposing this as a debugging aid. The idea is about correct programming,
> atleast
> > from my view. Ideally, if you kfree(x), then you should set x to NULL. So, either programmers
> do
> > it themselves or a ready made macro do it for them.
> 
> No, you should not.  I suspect that's the basic point you're missing.
> 
> 

Any strong reason why not? x has some value that does not make sense and can create only problems.
And as I explained, it can result in longer code too. So, why keep this value around. Why not
re-initialize it to NULL.

If x should not be re-initialized to NULL, then by the same logic, we should not even initialize
local variables. And all of us know that local variables should be initialized.

I would like to know a good reason as to why x should not be set to NULL.

-Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
