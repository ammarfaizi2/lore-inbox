Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbUATQg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 11:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUATQg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 11:36:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:26787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265597AbUATQgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 11:36:55 -0500
Date: Tue, 20 Jan 2004 08:37:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm5
Message-Id: <20040120083704.482f860c.akpm@osdl.org>
In-Reply-To: <20040120111441.A14570@infradead.org>
References: <20040120000535.7fb8e683.akpm@osdl.org>
	<20040120111441.A14570@infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> Any reason you keep CardServices-compatibility-layer.patch around?

err, it's my way of reminding myself that the issue isn't fully resolved. 
Smarter people would use a pencil and a notebook or something.

> Having a compat layer for old driver around just for some architectures,
> thus having drivers that only compile on some for no deeper reasons sounds
> like an incredibly bad idea.  Especially when that API is not used by any
> intree driver and only in -mm ;)

Yes, we were concerned about avoiding breaking the various random
out-of-tree pcmcia drivers which people use.  Russell would prefer that if
we _do_ have a compat layer it should be implemented in a different manner.

But we're all fairly uncertain that the compat layer is needed - converting
a driver is a pretty simple exercise, and Davd Hinds doesn't intend to
maintain his drivers into 2.6.

So the compatibility layer will probably go away soon, unless something
happens to bring it back into consideration.
