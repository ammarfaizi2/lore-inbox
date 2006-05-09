Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWEIGgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWEIGgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 02:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWEIGgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 02:36:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27614 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751394AbWEIGgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 02:36:38 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions 
In-reply-to: Your message of "Tue, 09 May 2006 08:22:59 +0200."
             <44603543.8070205@colorfullife.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 May 2006 16:35:23 +1000
Message-ID: <10406.1147156523@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul (on Tue, 09 May 2006 08:22:59 +0200) wrote:
>What about:
>- switch from power of two kmalloc caches to slighly smaller caches.
>- change the kmalloc(PAGE_SIZE) users to get_free_page(). 
>get_free_page() is now fast, too.
>- use cachep= *((struct kmem_cache **)(objp & 0xfff))

0xfff?  (PAGE_SIZE - 1) surely.  Not all the world is a 386.

