Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTLLEFX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 23:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTLLEFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 23:05:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:57024 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264430AbTLLEFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 23:05:16 -0500
Date: Thu, 11 Dec 2003 20:00:55 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au, zaitcev@yahoo.com
Subject: Re: [PATCH] Update Documentation/DocBook/kernel-locking.tmpl
Message-Id: <20031211200055.778ca906.rddunlap@osdl.org>
In-Reply-To: <20031211153349.18368656.rddunlap@osdl.org>
References: <20031211153349.18368656.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| 
| This has needed doing for a while.  Reviews welcome. 
| 
| As an attachment because it's about 64k "raw".


Some could be fuser errors (with docbook stylesheets etc.)...


a.  uses "gloss-timer" and "gloss-timers": choose one

b.  docbook complained about many unclosed or unmatched instances
    of </sect1>, </chapter>, </listitem>, etc.

c.  docbook complains about some 'C' syntactic items that are
inside <LiteralLayout> or <programlisting>.  E.g.:

- 'cache' in
	list_for_each_entry(i, &cache, list)

- 'obj-' in
	list_del(&obj->list);

- 'cache_lock' in
	down(&cache_lock);

(see the pattern: '&' shouldn't be special inside these blocks,
or at least that's how I think about it, but the software disagrees)


- docbook (at least my version) dislikes these #includes:
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/rcupdate.h>
 #include <asm/semaphore.h>
 #include <asm/errno.h>


I'd read it for content soonish.

Thanks for the update.

--
~Randy
