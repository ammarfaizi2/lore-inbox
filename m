Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbSI3AAF>; Sun, 29 Sep 2002 20:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSI2X70>; Sun, 29 Sep 2002 19:59:26 -0400
Received: from zero.aec.at ([193.170.194.10]:5130 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261851AbSI2X6o>;
	Sun, 29 Sep 2002 19:58:44 -0400
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
References: <20020929152731.GA10631@averell>
	<20020929160113.K5659@devserv.devel.redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 30 Sep 2002 02:04:02 +0200
In-Reply-To: <20020929160113.K5659@devserv.devel.redhat.com>
Message-ID: <m3ptuw5onh.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

> On Sun, Sep 29, 2002 at 05:27:31PM +0200, Andi Kleen wrote:
> > 
> > gcc 3.2 has an __attribute__((malloc)) function attribute. It tells gcc
> > that a function returns newly allocated memory and that the return pointer
> > cannot alias with any other pointer in the parent function. This often
> > allows gcc to generate better code because the optimizer doesn't need take
> > pointer aliasing in account.
> 
> Does this matter when the kernel is compiled with -fno-strict-aliasing?

I don't know. But it's certainly worth trying, isn't it ?  Giving the 
compiler more information can't be a bad thing.

-Andi
