Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTFBBda (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 21:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbTFBBd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 21:33:29 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:32267 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264780AbTFBBd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 21:33:28 -0400
Date: Sun, 1 Jun 2003 22:47:24 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
Message-ID: <20030602014723.GF4179@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, chas@cmf.nrl.navy.mil,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <1054497613.5863.4.camel@dhcp22.swansea.linux.org.uk> <200306012300.h51N0AsG023776@ginger.cmf.nrl.navy.mil> <20030601.184254.71111683.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601.184254.71111683.davem@redhat.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jun 01, 2003 at 06:42:54PM -0700, David S. Miller escreveu:
>    From: chas williams <chas@cmf.nrl.navy.mil>
>    Date: Sun, 01 Jun 2003 18:58:26 -0400
> 
>    In message <1054497613.5863.4.camel@dhcp22.swansea.linux.org.uk>,Alan Cox writes:
>    >Then why are you using spin_lock_irqsave ?
>    
>    meaning just use spin_lock() or what?
>    
> Alan/Chas, there are two different issues here:
> 
> 1) Aparently the bug only needs to be worked around when
>    multiple cpus can access the card at the same time.
> 
>    Therefore on uniprocessor the bug isn't relevant.
> 
> 2) Therefore, the lock needs to protect register accesses
>    from all contexts.  Therefore he needs an IRQ protecting
>    lock.
> 
> Therefore it isn't legal for him to use a non-IRQ protecting
> spinlock.
> 
> I personally don't think it's worth all the maintainence cost
> to special case all of this junk for uniprocessor.

Agreed.

- Arnaldo
