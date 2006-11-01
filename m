Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992668AbWKAQuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992668AbWKAQuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992669AbWKAQuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:50:23 -0500
Received: from ns1.coraid.com ([65.14.39.133]:64966 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S2992668AbWKAQuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:50:22 -0500
Date: Wed, 1 Nov 2006 11:36:28 -0500
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.19 patch] drivers/block/aoe/aoedev.c: fix NULL dereference
Message-ID: <20061101163628.GC20570@coraid.com>
References: <20061101004025.GY27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101004025.GY27968@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:40:25AM +0100, Adrian Bunk wrote:
> This patch fixes a NULL dereference introduced by
> commit e407a7f6cd143b3ab4eb3d7e1cf882e96b710eb5:
> 
> This quite unusual error handling through a switch introduces NULL 
> dereferences if exactly one of the two k{c,z}alloc's failed.

Hmm.  If exactly one of the two fails, then the value of the switch
conditional is 1 (well, certainly not zero).  It will jump over the
zero case, and there's a return in the default case, so I'm having
trouble seeing the danger.

What exactly is Coverity saying?  That would be interesting to know.

-- 
  Ed L Cashin <ecashin@coraid.com>
