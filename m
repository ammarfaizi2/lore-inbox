Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQKFAzu>; Sun, 5 Nov 2000 19:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129195AbQKFAzk>; Sun, 5 Nov 2000 19:55:40 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:5382 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129117AbQKFAzU>; Sun, 5 Nov 2000 19:55:20 -0500
Date: Mon, 6 Nov 2000 00:54:51 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10) 
In-Reply-To: <1992.973471650@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0011060050030.11842-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Keith Owens wrote:

> I'm not sure why you think this can be used for module persistent
> storage.  If a module calls inter_module_register() on load, it should
> call inter_module_unregister() on unload.  All the registered data
> points into the loaded module, remove the module and the storage
> disappears as well.

You can kmalloc() both the im_name and userdata arguments to
inter_module_register and you ought to be able to pass NULL as the owner.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
