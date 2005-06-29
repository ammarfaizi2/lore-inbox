Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVF2LU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVF2LU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVF2LU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:20:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11488 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262554AbVF2LUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:20:45 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: kmalloc without GFP_xxx?
Date: Wed, 29 Jun 2005 14:20:09 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200506291402.18064.vda@ilport.com.ua> <1120043739.3196.32.camel@laptopd505.fenrus.org>
In-Reply-To: <1120043739.3196.32.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291420.09956.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 14:15, Arjan van de Ven wrote:
> On Wed, 2005-06-29 at 14:02 +0300, Denis Vlasenko wrote:
> > Hi,
> > It struck me that kernel actually can figure out whether it's okay
> > to sleep or not by looking at combination of (flags & __GFP_WAIT)
> > and ((in_atomic() || irqs_disabled()) as it already does this for
> > might_sleep() barfing:
> 
> that is not enough.
> 
> you could be holding a spinlock for example!
> 
> (and no that doesn't set in_atomic() always)

but it sets irqs_disabled() IIRC.
--
vda

