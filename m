Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbUANJpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbUANJpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:45:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5294 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265369AbUANJn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:43:27 -0500
Date: Wed, 14 Jan 2004 04:43:05 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] string fixes for gcc 3.4
Message-ID: <20040114094305.GQ31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040114091543.GA2024@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114091543.GA2024@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 10:15:43AM +0100, Andi Kleen wrote:
> 
> gcc 3.4 optimizes sprintf(foo,"%s",string) into strcpy. Unfortunately
> that isn't seen by the inliner and linux/i386 has no out-of-line strcpy
> so you end up with a linker error.

The other alternative is -ffreestanding.  Kernel in its current shape
certainly is not a hosted environment.
But I agree GCC does a better job with string/memory functions
than kernel with its inlines.

	Jakub
