Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVB1OJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVB1OJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVB1OIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:08:23 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:4297 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261596AbVB1OGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:06:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=G6P3t84XQxnx0RLqK0c3BZ2fm3VIGDGnkUo0r8uj9kVWXIzdTKxUsf3pTjDkexiH7UOXYChAWkCYuaedlSbKXXkovCIDrexZ5ffEzHAYLCS+P7/A1PptWt3vphtyC0CmFCQAUqU2rVCx4sXAykRrLcqymOQHOgJT4+yjrXp3/r8=
Message-ID: <d120d50005022806062bee9738@mail.gmail.com>
Date: Mon, 28 Feb 2005 09:06:50 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Cc: "colbuse@ensisun.imag.fr" <colbuse@ensisun.imag.fr>,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: <1109599352.6298.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109596437.422319158044b@webmail.imag.fr>
	 <d120d5000502280548733724a0@mail.gmail.com>
	 <1109599352.6298.94.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005 15:02:32 +0100, Arjan van de Ven
<arjan@infradead.org> wrote:
> \
> > > >> + for(npar = NPAR-1; npar < NPAR; npar--)
> > >
> > > >How many times do you want this for loop to run?
> > >
> > > NPAR times :-). As I stated, npar is unsigned.
> > >
> >
> > for (npar = NPAR - 1; npar >= 0; npar--)
> >
> > would be more readable and may be even faster on a dumb compiler than
> > your variant. Still, I'd have compiler worry about such
> > micro-optimizations.
> 
> actually that goes wrong for npar unsigned...
> 
> 

Oops, you are right... 

-- 
Dmitry
