Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261780AbSI2T4z>; Sun, 29 Sep 2002 15:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbSI2T4y>; Sun, 29 Sep 2002 15:56:54 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:23698 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261780AbSI2T4p>; Sun, 29 Sep 2002 15:56:45 -0400
Date: Sun, 29 Sep 2002 16:01:13 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20020929160113.K5659@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20020929152731.GA10631@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929152731.GA10631@averell>; from ak@muc.de on Sun, Sep 29, 2002 at 05:27:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:27:31PM +0200, Andi Kleen wrote:
> 
> gcc 3.2 has an __attribute__((malloc)) function attribute. It tells gcc
> that a function returns newly allocated memory and that the return pointer
> cannot alias with any other pointer in the parent function. This often
> allows gcc to generate better code because the optimizer doesn't need take
> pointer aliasing in account.

Does this matter when the kernel is compiled with -fno-strict-aliasing?

	Jakub
