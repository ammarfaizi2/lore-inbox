Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTILDDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 23:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbTILDDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 23:03:08 -0400
Received: from dp.samba.org ([66.70.73.150]:12480 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261239AbTILDDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 23:03:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jakub Jelinek <jakub@redhat.com>,
       Dan Aloni <da-x@gmx.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
Subject: Re: [BK PATCH] One strdup() to rule them all 
In-reply-to: Your message of "Thu, 11 Sep 2003 18:22:23 +0200."
             <20030911162223.GB3989@wohnheim.fh-wedel.de> 
Date: Fri, 12 Sep 2003 11:57:20 +1000
Message-Id: <20030912030305.6C1442C089@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030911162223.GB3989@wohnheim.fh-wedel.de> you write:
> Andries, would you still object this function?
> 
> char *strdup(const char *s, int flags)
> {
> 	char *rv = kmalloc(strlen(s)+1, flags);
> 	if (rv)
> 		strcpy(rv, s);
> 	return rv;
> }

No.  We've been here.  There are only around 50 users/potential users
of such a thing in the kernel, and seven implementations, but Linus
doesn't like it, so let's not waste more time on this please.

Rusty.

PS. kstrdrup is a better name since the args are different, a-la
    kmalloc.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
