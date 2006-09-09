Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWIIBur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWIIBur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 21:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWIIBur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 21:50:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751312AbWIIBur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 21:50:47 -0400
Date: Fri, 8 Sep 2006 18:50:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] kmemdup: introduce
Message-Id: <20060908185043.05bd4796.akpm@osdl.org>
In-Reply-To: <20060909013555.GC5192@martell.zuzino.mipt.ru>
References: <20060909013555.GC5192@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sep 2006 05:35:55 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> P.S.: No idea why kstrdup() and kzalloc() use _____________kmalloc(),

It's all to do with slab debugging and __kmalloc_track_caller(): we want
to record the _caller_ of kstrdup() within the slab object rather than kstrdup()
itself.
