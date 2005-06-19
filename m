Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVFSTt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVFSTt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 15:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVFSTt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 15:49:59 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:65162 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261293AbVFSTt5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 15:49:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s2ADQ0greYZMi1VX2INA2DZgeJj+jxJkzb3QSG9TFCHMnDJdEBi50whO/rPAAiypBUsCJpc2H/dmV1UvmXt7CKl4DZF6+LWO+LoH94igGKBe0XCQpwb6nVj2SUGNfi057U1h0N8aAxqyhlX6YHWHAjTAmtI/wSEW3b+pmaa9dX0=
Message-ID: <9a87484905061912492d6a9952@mail.gmail.com>
Date: Sun, 19 Jun 2005 21:49:55 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Michael Buesch <mbuesch@freenet.de>
Subject: Re: [PATCH] Small kfree cleanup, save a local variable.
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       "Rickard E. (Rik) Faith" <faith@redhat.com>,
       Rik Faith <faith@cs.unc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200506192137.59719.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0506192129300.2832@dragon.hyggekrogen.localhost>
	 <200506192137.59719.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/05, Michael Buesch <mbuesch@freenet.de> wrote:
> Quoting Jesper Juhl <juhl-lkml@dif.dk>:
> > Here's a patch with a small improvement to kernel/auditsc.c .
> > There's no need for the local variable  struct audit_entry *e  ,
> > we can just call kfree directly on container_of() .
> 
> Did you look at the assembly output? Does it change?
> I think the compiler optimizes this variable away, anyway.
> So, if there's no improvement, I would personally prefer the
> original form as it's more readable.
> 
gcc does optimize it away. 
Personally I find both forms equally readable, and with the change the
source matches what the code actually ends up as, but I don't care
much one way or the other.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
