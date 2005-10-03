Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbVJCTkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbVJCTkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVJCTkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:40:22 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:27456 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932659AbVJCTkU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:40:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aKmcPsJYEDTUUjsJXvnEVGa9eqfgRcJEF6/N41CkRT7EdSfKoY2jfnJcC9efq3ZK0RzUTUE8Z3XJDkRkfL7bB6hpJd5P40VuZTD65ksfUen85WvF4uE1EG9K9L7SpAOaVSEzyq/kmI0uYpWGswga2Ikrtw1Fs01l6nDTOTeFMZE=
Message-ID: <35fb2e590510031240t27147ea9w8437be0c29341c2d@mail.gmail.com>
Date: Mon, 3 Oct 2005 20:40:17 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: ppc boot entry point
Cc: "Dave B. Sharp" <daveb_sharp@yahoo.ca>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051003172241.GB6735@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051003153527.53128.qmail@web32909.mail.mud.yahoo.com>
	 <20051003172241.GB6735@smtp.west.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Tom Rini <trini@kernel.crashing.org> wrote:
> On Mon, Oct 03, 2005 at 11:35:27AM -0400, Dave B. Sharp wrote:
>
> > Hey there,
> > Can anyone tell me how to find te entry point (i.e.
> > address) into the kernel, when control is passed from
> > the boot loader?
> > Where are the arguements such as the boot parameters.
> > I am compiling for a generic ppc kernel at this point.

> This is PowerPC specific stuff.

Yes, it is. In addition to your comments, Tom, it's worth looking in
the corresponding head.S, head_4xx.S or whatever files to see that the
kernel is called much like a regular function with arguments in
registers r3 upwards. You'll find most of what you want to know by
going through from early_init onwards.

Jon.
