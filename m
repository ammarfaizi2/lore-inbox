Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVGGHnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVGGHnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 03:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVGGHnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 03:43:13 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:9139 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261234AbVGGHnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 03:43:12 -0400
References: <20050707071357.99494.qmail@web81304.mail.yahoo.com>
In-Reply-To: <20050707071357.99494.qmail@web81304.mail.yahoo.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Mark Gross <mgross@linux.intel.com>, Willy Tarreau <willy@w.ods.org>,
       Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Date: Thu, 07 Jul 2005 10:43:11 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CCDD0F.0000483E@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry, 

Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> > Fair enough, "static const int" would work here too. Defines should be 
> > avoided because they allow you to override a value without ever noticing it.

Dmitry Torokhov writes:
> Would not this cause compiler to allocate memory for the constant?
> I suppose if GCC is really good it could eliminate allocation since
> nothing takes its address, but I am not sure. 
> 
> With #define you can be sure that it is just a constant expression.

Constant propagation pass will eliminate the allocation. I checked GCC 3.3.5 
and does this with -O1. 

                Pekka 

