Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVIRQc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVIRQc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVIRQc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:32:28 -0400
Received: from peabody.ximian.com ([130.57.169.10]:40582 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S932112AbVIRQc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:32:27 -0400
Subject: Re: p = kmalloc(sizeof(*p), )
From: Robert Love <rml@novell.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20050918100627.GA16007@flint.arm.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 18 Sep 2005 12:32:26 -0400
Message-Id: <1127061146.6939.6.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-18 at 11:06 +0100, Russell King wrote:

> +The preferred form for passing a size of a struct is the following:
> +
> +       p = kmalloc(sizeof(*p), ...);
> +
> +The alternative form where struct name is spelled out hurts readability and
> +introduces an opportunity for a bug when the pointer variable type is changed
> +but the corresponding sizeof that is passed to a memory allocator is not.

Agreed.

Also, after Alan's #4:

5.  Contrary to the above statement, such coding style does not help,
    but in fact hurts, readability.  How on Earth is sizeof(*p) more
    readable and information-rich than sizeof(struct foo)?  It looks
    like the remains of a 5,000 year old wolverine's spleen and
    conveys no information about the type of the object that is being
    created.

	Robert Love


