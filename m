Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWAZLzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWAZLzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWAZLzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:55:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60289 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751332AbWAZLzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:55:11 -0500
Date: Thu, 26 Jan 2006 12:55:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Message-ID: <20060126115500.GA1609@elf.ucw.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This set of patches represents the freezer upgrade patches from Suspend2.
> 
> The key features of this changeset are:
> 
> - Use of Christoph Lameter's todo list notifiers, which help with SMP
>   cleanness.
> - Splitting the freezing of kernel and userspace processes. Freezing
>   currently suffers from a race because userspace processes can be
>   submitting work for kernel threads, thereby stopping them from
>   responding to freeze messages in a timely manner. The freezer can
>   thus give up when it doesn't really need to. (This is not normally
>   a problem only because load is not usually high).

Exactly. 6 seconds should be enough for signal to be delivered.

> - The use of bdev freezing to ensure filesystems are properly frozen,
>   thereby increasing the integrity of on-disk data in the case where
>   a resume doesn't occur. This is also helpful in the case of Suspend2,
>   where we don't atomically copy all memory, instead writing LRU pages
>   separately.

We have talked about this before... we alredy have sync there, and
that's enough. Your patch only makes code more complex for no gain.

								Pavel
-- 
Thanks, Sharp!
