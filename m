Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVHYMkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVHYMkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 08:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVHYMkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 08:40:36 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:52733 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964963AbVHYMkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 08:40:35 -0400
From: Ian Campbell <ijc@hellion.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cifs-client@lists.samba.org,
       Asser =?ISO-8859-1?Q?Fem=F8?= <asser@diku.dk>
In-Reply-To: <20050823152331.GA10486@mail.shareable.org>
References: <20050823130023.GB8305@diku.dk>
	 <20050823152331.GA10486@mail.shareable.org>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 13:40:18 +0100
Message-Id: <1124973618.17190.9.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.3.3
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: dnotify/inotify and vfs questions
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 16:23 +0100, Jamie Lokier wrote:
>     <receive some request>...
>     if (any_dnotify_or_inotify_events_pending) {
>         read_dnotify_or_inotify_events();
>         if (any_events_related_to(file)) {
>             store_in_userspace_stat_cache(file, stat(file));
>         }
>     }
>     stat_info = lookup_userspace_stat_cache(file);
> 
> Now that's a silly way to save one system call in the fast path by itself.

I'm not that familiar with inotify internals but doesn't
read_dnotify_or_inotify_events() or
any_dnotify_or_inotify_events_pending() involve a syscall?

Ian.
-- 
Ian Campbell
Current Noise: Primordial - The Coffin Ships

Today is the first day of the rest of the mess.

