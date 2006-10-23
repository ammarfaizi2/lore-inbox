Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWJWHqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWJWHqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWJWHqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:46:31 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:62348 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751697AbWJWHqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:46:30 -0400
Date: Mon, 23 Oct 2006 03:46:28 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Amit Choudhary <amit2030@gmail.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc2] [REVISED] net/ipv4/multipath_wrandom.c: check
 kmalloc() return value.
In-Reply-To: <20061022235958.b31d7529.amit2030@gmail.com>
Message-ID: <Pine.LNX.4.64.0610230341080.16474@d.namei>
References: <20061022235958.b31d7529.amit2030@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006, Amit Choudhary wrote:

> Description: Check the return value of kmalloc() in function wrandom_set_nhinfo(), in file net/ipv4/multipath_wrandom.c.
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>

Acked-by: James Morris <jmorris@namei.org>

> @@ -242,6 +242,9 @@ static void wrandom_set_nhinfo(__be32 ne
>  		target_route = (struct multipath_route *)
>  			kmalloc(size_rt, GFP_ATOMIC);

It'd be nice to see these casts removed in a future cleanup.



- James
-- 
James Morris
<jmorris@namei.org>
