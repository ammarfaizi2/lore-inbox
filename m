Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWH2ASP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWH2ASP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 20:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWH2ASP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 20:18:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14483 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964931AbWH2ASO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 20:18:14 -0400
Date: Mon, 28 Aug 2006 17:18:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Richard Knutsson <ricknu-0@student.ltu.se>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
Message-Id: <20060828171804.09c01846.akpm@osdl.org>
In-Reply-To: <20060828093202.GC8980@infradead.org>
References: <44EFBEFA.2010707@student.ltu.se>
	<20060828093202.GC8980@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 10:32:02 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Sat, Aug 26, 2006 at 05:24:42AM +0200, Richard Knutsson wrote:
> > Hello
> > 
> > Just would like to ask if you want patches for:
> 
> Total NACK to any of this boolean ididocy.  I very much hope you didn't
> get the impression you actually have a chance to get this merged.

I was kinda planning on merging it ;)

I can't say that I'm in love with the patches, but they do improve the
situation.

At present we have >50 different definitions of TRUE and gawd knows how
many private implementations of various flavours of bool.

In that context, Richard's approach of giving the kernel a single
implementation of bool/true/false and then converting things over to use it
makes sense.  The other approach would be to go through and nuke the lot,
convert them to open-coded 0/1.

I'm not particularly fussed either way, really.  But the present situation
is nuts.
