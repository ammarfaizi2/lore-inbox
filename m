Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVF2LTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVF2LTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVF2LTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:19:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:39317 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262543AbVF2LTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:19:21 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jens Axboe <axboe@suse.de>
Subject: Re: kmalloc without GFP_xxx?
Date: Wed, 29 Jun 2005 14:18:43 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200506291402.18064.vda@ilport.com.ua> <20050629111537.GF14589@suse.de>
In-Reply-To: <20050629111537.GF14589@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291418.43748.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 14:15, Jens Axboe wrote:
> On Wed, Jun 29 2005, Denis Vlasenko wrote:
> > So why can't we have kmalloc_auto(size) which does GFP_KERNEL alloc
> > if called from non-atomic context and GFP_ATOMIC one otherwise?
> 
> Because it's a lot better in generel if we force people to think about
> what they are doing wrt memory allocations. You should know if you are
> able to block or not, a lot of functions exported require you to have
> this knowledge anyways. Adding these auto-detection type functions
> encourages bad programming, imho.

Those 'bad programming' people can simply use GFP_ATOMIC always, no?
This would be even worse because kmalloc_auto() will sleep
if it's allowed, but GFP_ATOMIC would not.
--
vda

