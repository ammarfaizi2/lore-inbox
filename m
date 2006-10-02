Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWJBVJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWJBVJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWJBVJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:09:40 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:63409 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965122AbWJBVJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:09:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=EWuUsu8KH7A1zt75nEVU1DbUAetWDFOYQRbhdbbWDChWY+HezPY7HgGUiYi/9rO4SBS4HHxkkWGC0Rsjdzj40cV5BpsdQNH6j0G1guOysPbTiWXQIVV+jqXrc7qiaPiT6gTZeLA9e5oS8RbqnS6n+lEm/NcKztbLRhjpRaUvKZw=  ;
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.18-git] SPI -- Freescale iMX SPI controller driver
Date: Mon, 2 Oct 2006 14:09:34 -0700
User-Agent: KMail/1.7.1
Cc: "Thiago Galesi" <thiagogalesi@gmail.com>,
       "Andrea Paterniani" <a.paterniani@swapp-eng.it>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <200610020816.58985.david-b@pacbell.net> <200610021310.15374.david-b@pacbell.net> <20061002133806.10bd652d.akpm@osdl.org>
In-Reply-To: <20061002133806.10bd652d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021409.35518.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 1:38 pm, Andrew Morton wrote:
> On Mon, 2 Oct 2006 13:10:14 -0700
> David Brownell <david-b@pacbell.net> wrote:
> 
> > > > +/* Message state */
> > > > +#define START_STATE                    ((void*)0)
> > > > +#define RUNNING_STATE                  ((void*)1)
> > > > +#define DONE_STATE                     ((void*)2)
> > > > +#define ERROR_STATE                    ((void*)-1)
> > > 
> > > !?!??!?!
> > 
> > Now that you mention it ... let me second that comment!
> 
> These are "better enums".  The problem with C's enums is that it's possible
> to mix them with integers and the compiler just swallows it.  With the
> above, you'll get a warning if you make that mistake.

I see.


>  Do the enum-mismatch checking in sparse.

With __bitwise types and values, for example...

- Dave

 
