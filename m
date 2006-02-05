Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWBEJMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWBEJMX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 04:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWBEJMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 04:12:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751674AbWBEJMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 04:12:21 -0500
Date: Sun, 5 Feb 2006 01:11:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, lee.schermerhorn@hp.com,
       Reiserfs-Dev@namesys.com
Subject: Re: Fw: Re: [PATCH] 2.6.16-rc-mm4 reiser4 calls try_to_unmap() with
 1 arg -- now takes 2
Message-Id: <20060205011152.7f9b7aa9.akpm@osdl.org>
In-Reply-To: <43E5BB2E.5000203@namesys.com>
References: <20060205003039.3067e43c.akpm@osdl.org>
	<43E5BB2E.5000203@namesys.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> Umm, no, copy on capture needs to get enabled again as soon as we get
>  past issues outsiders care about, and start dealing again with improving
>  the code in the ways we think matter.  There are real problems that are
>  addressed by copy on capture.  That it has not been worked on since
>  2.6.5 just sadly indicates how successful folks have been in distracting
>  us for so long.

Dinking with rmap internals from within a filesystem is a real problem. 
Whatever needs to be done there should be done within core MM if it's done
anywhere so it actually gets maintained by the people who are likely to
break it.

Something like
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/broken-out/add-page-becoming-writable-notification.patch
might be what you're after.

