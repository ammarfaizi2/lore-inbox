Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVARCZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVARCZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVARCWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:22:31 -0500
Received: from ozlabs.org ([203.10.76.45]:8137 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261153AbVARCUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 21:20:18 -0500
Subject: Re: [PATCH] Fix kallsyms/insmod/rmmod race
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org
In-Reply-To: <31453.1105979239@redhat.com>
References: <31453.1105979239@redhat.com>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 13:20:03 +1100
Message-Id: <1106014803.30801.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 16:27 +0000, David Howells wrote:
> The attached patch fixes a race between kallsyms and insmod/rmmod.

Hi David,

	The more I looked at this, the more I warmed to it.  I've known for a
while that people are using kallsyms not for OOPS (eg. /proc/$$/wchan),
so we should provide a "grabs locks" version, but this solution gets
around that nicely, while making life more certain for the oops case,
too.

Good work!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

