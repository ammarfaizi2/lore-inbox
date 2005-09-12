Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVILSIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVILSIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVILSIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:08:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:38333 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750824AbVILSIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:08:36 -0400
Message-ID: <4325C425.4030002@namesys.com>
Date: Mon, 12 Sep 2005 11:08:37 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Reiserfs-Dev@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: List of things requested by lkml for reiser4 inclusion (to review)
References: <200509091817.39726.zam@namesys.com>	<4321C806.60404@namesys.com> <20050909144142.0f96802f.akpm@osdl.org>
In-Reply-To: <20050909144142.0f96802f.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>
>The type-unsafety of existing list_heads gives me conniptions too.  Yes,
>it'd be nice to have a type-safe version available.
>
>That being said, I don't see why such a thing cannot be a wrapper around
>the existing list_head functions.  Yes, there will be some ghastly
>C-templates-via-CPP stuff, best avoided by not looking at the file ;)
>
>We should aim for a complete 1:1 relationship between list_heads and
>type-safe lists.  So people know what they're called, know how they work,
>etc.  We shouldn't go adding things called rx_event_list_pop_back() when
>everyone has learned the existing list API.
>
>Of course, it would have been better to do this work as a completely
>separate kernel feature rather than bundling it with a filesystem.  If this
>isn't a thing your team wants to take on now then yes, I'd be inclined to
>switch reiser4 to list_heads.
>
>  
>
Vladimir spent 24 hours straight unsafing the lists in reiser4, and
didn't finish yet.  We need 1-2 more days to address this before we can
submit reiser4.  I hope this delay will not be too much of a problem.

Hans
