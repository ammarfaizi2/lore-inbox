Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269859AbUJMVVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269859AbUJMVVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 17:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269862AbUJMVVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 17:21:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:55188 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269859AbUJMVVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 17:21:15 -0400
Date: Wed, 13 Oct 2004 23:21:04 +0200
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: brad@danga.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.6.9-rc4, dual Opteron, NUMA, 8GB
Message-Id: <20041013232104.7e8dd97e.ak@suse.de>
In-Reply-To: <416D9139.1060200@osdl.org>
References: <Pine.LNX.4.58.0410131204580.31327@danga.com>
	<416D8999.7080102@pobox.com>
	<Pine.LNX.4.58.0410131302190.31327@danga.com>
	<416D8C33.9080401@osdl.org>
	<Pine.LNX.4.58.0410131328400.31327@danga.com>
	<416D9139.1060200@osdl.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 13:34:01 -0700
"Randy.Dunlap" <rddunlap@osdl.org> wrote:


> 
> > Who's responsible for the K8_NUMA stuff?  I'd love to work with them to
> > narrow this down.
> 
> Andi Kleen (SUSE).  Copied.

It looks like memory corruption somewhere. I suspect not directly related to NUMA,
but the different memory layout with NUMA may trigger it.

I would enable CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC and see if that
triggers it elsewhere.

First suspection would be the device driver. Perhaps you can test it with
a different block device?

-Andi
