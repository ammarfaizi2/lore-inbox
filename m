Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161284AbWASI6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbWASI6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161285AbWASI6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:58:17 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:44879 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161284AbWASI6R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:58:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XqFRlMzu7ZgVzMQXDEqvkjKUX2pn1DrhZmIdVReNQcqdfA33mnC5KSefkZ8mcw1KeE9jiO34pYpP6OUJpQkKKYaSkwQgefAEHyK+OoKLUxlfKgBMOHKL3bm8PNSqfgYS+crAf2RDmxINpTnXITH+DU8quJ6I2eX5bPGa6RaGp1g=
Message-ID: <84144f020601190058s2e8e86a8ya761fcb4fdd8eeaa@mail.gmail.com>
Date: Thu, 19 Jan 2006 10:58:13 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: [PATCH] 2.6.16-rc1-mm1 - produce useful info for kzalloc with DEBUG_SLAB
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200601190830.k0J8UG9Q008899@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601190830.k0J8UG9Q008899@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valdis,

On 1/19/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> The following patch makes a few minor changes so the CONFIG_DEBUG_SLAB
> statistics report the actual caller for kzalloc() - otherwise its call to
> kmalloc() just points at kzalloc().  Basically, we force __always_inline on
> several routines, so the __builtin_return_address calls point where we
> want them to point, even if gcc wouldn't otherwise do it.

Couldn't we use this [1] trick Steven came up with for this?

  1. http://article.gmane.org/gmane.linux.kernel/362494

                                    Pekka
