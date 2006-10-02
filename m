Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWJBRER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWJBRER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWJBREQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:04:16 -0400
Received: from mail.impinj.com ([206.169.229.170]:49870 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S932535AbWJBREP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:04:15 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 4/4] fdtable: Implement new pagesize-based fdtable allocation scheme.
Date: Mon, 2 Oct 2006 10:04:13 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200610011414.30443.vlobanov@speakeasy.net> <p73y7rzghos.fsf@verdi.suse.de>
In-Reply-To: <p73y7rzghos.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021004.13634.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 03:01, Andi Kleen wrote:
> Vadim Lobanov <vlobanov@speakeasy.net> writes:
> > The allocation algorithm sizes the fdarray in such a way that its memory
> > usage increases in easy page-sized chunks. Additionally, it tries to
> > account for the optimal usage of the allocators involved: kmalloc() for
> > sizes less than a page, and vmalloc() with page granularity for sizes
> > greater than a page.
>
> Best would be to avoid vmalloc() completely because it can be quite
> costly

It's possible. This switch between kmalloc() and vmalloc() was there in the 
original code, and I didn't feel safe ripping it out right now. We can always 
explore this approach too, however.

What is the origin and history of this particular code? (It's been there since 
at least 2.4.x.) Who put in the switch between the two allocators, and for 
what reason? Is that reason still valid?

> -Andi

Thanks for the input.

-- Vadim Lobanov
