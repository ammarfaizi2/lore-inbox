Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbUKTCWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbUKTCWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbUKTCWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:22:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1994 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262291AbUKTCSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:18:25 -0500
Date: Fri, 19 Nov 2004 21:18:14 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jeffrey Mahoney <jeffm@novell.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] selinux: cache not freed if load_policy fails; reload
 BUG's
In-Reply-To: <a482d6bf0411191755420f1480@mail.gmail.com>
Message-ID: <Xine.LNX.4.44.0411192114420.12779-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If security_load_policy() fails on the first try, the cache is never cleaned
> up. When the policy is fixed and a reload is attempted, the old cache will
> still exist, causing a BUG() in kmem_cache_create().
> 
> This patch adds a destroy operation to clean up the cache on failure.

Looks correct to me.


- James
-- 
James Morris
<jmorris@redhat.com>


