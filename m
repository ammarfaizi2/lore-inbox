Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVEXADP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEXADP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEXACr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:02:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:9932 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261222AbVEWX7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:59:00 -0400
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-crypto@vger.kernel.org
In-Reply-To: <20050523162806.0e70ae4f.akpm@osdl.org>
References: <200505232300.j4NN07lE012726@hera.kernel.org>
	 <20050523162806.0e70ae4f.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 24 May 2005 09:58:10 +1000
Message-Id: <1116892690.30513.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 16:28 -0700, Andrew Morton wrote:

> This code can cause deadlocks on CONFIG_SMP && !CONFIG_PREEMPT kernels.
> 
> Please see http://lkml.org/lkml/2005/3/10/358
> 
> You (the programmer) *have* to know what context you're running in before
> doing a voluntary yield.  There is simply no way to work this out at
> runtime.

Hrm... Linus just merged it though...

Ben.


