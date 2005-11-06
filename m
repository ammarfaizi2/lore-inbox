Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVKFWvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVKFWvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVKFWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:51:46 -0500
Received: from systemlinux.org ([83.151.29.59]:23533 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S932067AbVKFWvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:51:45 -0500
Date: Sun, 6 Nov 2005 23:51:38 +0100
From: Andre Noll <maan@systemlinux.org>
To: Neil Brown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup detected on CPU#0! (linux-2.6.14)
Message-ID: <20051106225138.GF26862@skl-net.de>
References: <20051106193142.GD26862@skl-net.de> <17262.31781.497775.640424@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17262.31781.497775.640424@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08:56, Neil Brown wrote:
> This seems to suggest that the nfsd thread is always runnable, which
> implies a read-only load with everything in cache - at least for the
> 10 seconds leading up to each of these errors.  Is that likely?

Hm, not sure. I was compiling glibc and simultanously running a big
"cvs update" on the nfs server when one of these BUGs happened.

glibc source and the cvs tree live somewhere in /home and /home is
exported rw to a bunch of clients. But no client should have accessed
those two subdirs at that time.

> The following patch might fix it.  Please let me know the result.

Patch applied and rebooted. The box currently compiles glibc and
firefox in parallel. No problems so far.

Thanks a lot
Andre
-- 
Jesus not only saves, he also frequently makes backups
