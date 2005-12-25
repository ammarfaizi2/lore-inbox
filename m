Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVLYS2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVLYS2z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 13:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVLYS2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 13:28:55 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:17627 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750883AbVLYS2y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 13:28:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sxSgDR5K4Kk7HTROjSqM2Odm/oJ14xS97GHSAJZ+1fhsrJFP0dCCNw2p2gsTwihyYSZLjygUkiynD6WUpbZQi+h5XCZe5oseD4GIRjXcKdKPOb14mNsfIsGts8RVn5h7eGVsx9jGJNeVo/7K0wL9+swo58OpbMxYVC13VVoLqik=
Message-ID: <aec8d6fc0512251028v1338cc2cn2d8d58e4685c178@mail.gmail.com>
Date: Sun, 25 Dec 2005 19:28:53 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
To: Michael Buesch <mbuesch@freenet.de>
Subject: Re: kernel list / container_of aka list_entry question
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-mentors@selenic.com
In-Reply-To: <200512251910.49869.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aec8d6fc0512250850m4f8d4bd6y3772638d620548cd@mail.gmail.com>
	 <1e62d1370512250924r4e3078d0ubb8986d52ac8aeb@mail.gmail.com>
	 <200512251910.49869.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/05, Michael Buesch <mbuesch@freenet.de> wrote:

> > >         list_for_each(iterator, &priv->rxbuf.list) {
> > >                 struct ath_buf *bf = list_entry(iterator, (struct ath_buf), list);
>                                                               ^              ^
> Remove the parenthesis.

yikes. that helped. but it's somewhat weird IMHO... why ((struct foo)
*) wont work?
and it needs to be (struct foo *) ?


kind regards,
Mateusz
