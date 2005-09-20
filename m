Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVITIxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVITIxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVITIxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:53:48 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:4115 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964937AbVITIxq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:53:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ItinZq0vmuih/ars3au+gMLY7pEzgHaOEtTACwk5NI2MVNJFGPKdTAa/UYT0yJKqTkppMwkW3uDOZIsLe5tmPouf6CATMj8IEXMX9k8tdRaYlnM7un+vuL5BUrXXjojAv1LVQKHAKJEwSNh+jqBB+lIbRdoNTpfa9Jbeig3+fB4=
Message-ID: <84144f020509200153f0becf2@mail.gmail.com>
Date: Tue, 20 Sep 2005 11:53:42 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Robert Love <rml@novell.com>
Subject: Re: p = kmalloc(sizeof(*p), )
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <1127061146.6939.6.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	 <1127061146.6939.6.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/05, Robert Love <rml@novell.com> wrote:
> 5.  Contrary to the above statement, such coding style does not help,
>     but in fact hurts, readability.  How on Earth is sizeof(*p) more
>     readable and information-rich than sizeof(struct foo)?  It looks
>     like the remains of a 5,000 year old wolverine's spleen and
>     conveys no information about the type of the object that is being
>     created.

Yes it does. The semantics are clearly "I want enough memory to hold
the type this pointer points to." While sizeof(struct foo) might seem
more readable, it is in fact not as you have no way of knowing whether
the allocation is correct or not by looking at the line. So for
spotting allocation errors with grep, the shorter form is better (and
arguably less error-prone).

                                Pekka
