Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVISRZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVISRZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 13:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVISRZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 13:25:33 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:56459 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932513AbVISRZc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 13:25:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a63VDC2t/XyJgM+UVwTl9aCP3erzSPwnP3GMQZmk5SclO4TyoNYpHutjIvIlQDfqJ3UFz8xS6bYOchAJa6HlmW9L5XvfDBsIq/eWeSobXPFMQqnILkZAYhOgEiLcSD9yWdEuxzkBReBTJ4dXb8CCWI5HQYLmhPJOHgNaZPXfaaU=
Message-ID: <5fc59ff305091910252447d363@mail.gmail.com>
Date: Mon, 19 Sep 2005 10:25:29 -0700
From: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Reply-To: ganesh.venkatesan@gmail.com
To: Dan Aloni <da-x@monatomic.org>
Subject: Re: workaround large MTU and N-order allocation failures
Cc: Francois Romieu <romieu@fr.zoreil.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20050919071358.GA7107@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050918143526.GA24181@localdomain>
	 <20050918230822.GA5440@electric-eye.fr.zoreil.com>
	 <20050919071358.GA7107@localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

82546GB supports an incoming Rx packet to be received in multiple rx
buffers. A driver that enables this feature is under test currently.
What version of the e1000 are you using?

ganesh.

On 9/19/05, Dan Aloni <da-x@monatomic.org> wrote:
> On Mon, Sep 19, 2005 at 01:08:22AM +0200, Francois Romieu wrote:
> > Dan Aloni <da-x@monatomic.org> :
> > [...]
> > > The problem with large MTU is external memory fragmentation in
> > > the buddy system following high workload, causing alloc_skb() to
> > > fail.
> >
> > If the issue hits the Rx path, it is probably the responsibility of
> > the device driver. Which kind of hardware do you use ?
> 
> We are using a SuperMicro board and the network driver is e1000. The
> revision of the chipset is 82546GB-copper (maps to e1000_82546_rev_3).
> 
> This particular chipset does not support packet splitting, so we
> are looking for a hack on the skb layer.
> 
> --
> Dan Aloni
> da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
