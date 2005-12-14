Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbVLNXZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbVLNXZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVLNXZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:25:01 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:29633 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965061AbVLNXZA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:25:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ETkR6PIUKv4OoSyIUWQDf8QS/NBKhqeCM77Gu6nF1s4V09elYdKvCZFAqNYEL6D7Z3XvVN6NnE/0h3K2YDllyoQ7quMfOfoff9FY1lmfnL4kmh7eDDjYNeFl6OkR0iyicaB1cEcZ4azH2tww62DeWFrtSDMUn2FrrTVJgrwKqvc=
Message-ID: <9a8748490512141524g3e9ad169tfecbe6204a13376f@mail.gmail.com>
Date: Thu, 15 Dec 2005 00:24:59 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][expample patch] Make the kernel -Wshadow clean ?
In-Reply-To: <20051214232226.GD31955@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512150019.57124.jesper.juhl@gmail.com>
	 <20051214232226.GD31955@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Thu, Dec 15, 2005 at 12:19:57AM +0100, Jesper Juhl wrote:
> > -                     void (*dtor)(struct page *page);
> > +                     void (*dtor)(struct page *pge);
>
> Note that this one just needs to be:
>                         void (*dtor)(struct page *);
>

Yes, I considered just doing that, but was unsure if the name had been
used for some obscure readability or grep'ability reason, so I opted
to leave the name but just change it.. In future cases like this one
(if people actually want these patches) I'll just nuke the name.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
