Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTJAOUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTJAOUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:20:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:53510 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262225AbTJAOU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:20:28 -0400
Date: Wed, 1 Oct 2003 15:19:52 +0100
From: Dave Jones <davej@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
Message-ID: <20031001141950.GA13115@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 02:26:19PM +0100, Matthew Wilcox wrote:
 > 
 > I reviewed the dependency list for a file this morning to see why it was
 > being unnecessarily recompiled (a little fetish of mine, mostly harmless).
 > I was a little discombobulated to find this line:

Mmm discombobulation.

 >     $(wildcard include/config/higmem.h) \
 > 
 > Naturally, I assumed a typo somewhere.  It turns out there is indeed
 > a CONFIG_HIGMEM in include/linux/mm.h, but it's in a comment.  The
 > fixdep script doesn't parse C itself, so it doesn't know that this should
 > be ignored.

Maybe it should be taught to parse comments? There are zillions of
#endif /* CONFIG_FOO */
braces in the tree. Why is this one special ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
