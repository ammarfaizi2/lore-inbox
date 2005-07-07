Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVGGHPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVGGHPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 03:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVGGHPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 03:15:01 -0400
Received: from web81304.mail.yahoo.com ([206.190.37.79]:33170 "HELO
	web81304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261219AbVGGHOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 03:14:02 -0400
Message-ID: <20050707071357.99494.qmail@web81304.mail.yahoo.com>
Date: Thu, 7 Jul 2005 00:13:57 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Mark Gross <mgross@linux.intel.com>, Willy Tarreau <willy@w.ods.org>,
       Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
In-Reply-To: <courier.42CCD1CF.00004205@courier.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> Hi Dmitry, 
> 
> Mark Gross writes:
> > > > +
> > > > +/* 0 = Dynamic allocation of the major device number */
> > > > +#define TLCLK_MAJOR 252
> 
> Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> > > Enums, please. 
> > > 
> 
> Dmitry Torokhov writes:
> > But not here - it is a single constant, not a value of a distinct type.
> 
> Fair enough, "static const int" would work here too. Defines should be 
> avoided because they allow you to override a value without ever noticing it.
> 

Would not this cause compiler to allocate memory for the constant?
I suppose if GCC is really good it could eliminate allocation since
nothing takes its address, but I am not sure.

With #define you can be sure that it is just a constant expression.

-- 
Dmitry
