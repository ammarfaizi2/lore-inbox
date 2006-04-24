Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWDXJUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWDXJUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 05:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWDXJUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 05:20:10 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:48569 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751194AbWDXJUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 05:20:08 -0400
Subject: Re: [patch 4/4] change slab poison pattern
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt Mackall <mpm@selenic.com>,
       Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20060424083342.743876000@localhost.localdomain>
References: <20060424083333.217677000@localhost.localdomain>
	 <20060424083342.743876000@localhost.localdomain>
Date: Mon, 24 Apr 2006 12:20:03 +0300
Message-Id: <1145870404.21484.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-04-24 at 16:33 +0800, Akinobu Mita wrote:
> kref debugging cannot detect kref_put() with unreferenced object,
> when the structure including kref is allocated by slab
> and slab debugging config is enabled.
> 
> Because use-after-free poisoning make kref counter signed value.
> So this patch prevents it by changing poisoning pattern.

Then why not check against POISON_INUSE when CONFIG_SLAB_DEBUG in the
kref debugging code? I would prefer you didn't change the slab constants
(they're well known by everyone now) but if you must, at least stick a
big fat comment there.

			Pekka

