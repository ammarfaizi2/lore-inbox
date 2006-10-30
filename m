Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbWJ3E0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbWJ3E0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 23:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbWJ3E0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 23:26:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53430 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030516AbWJ3E0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 23:26:15 -0500
Date: Mon, 30 Oct 2006 15:24:19 +1100
From: David Chinner <dgc@sgi.com>
To: Vasily Averin <vvs@sw.ru>
Cc: David Howells <dhowells@redhat.com>, Neil Brown <neilb@suse.de>,
       Jan Blunck <jblunck@suse.de>, Olaf Hering <olh@suse.de>,
       Balbir Singh <balbir@in.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
Message-ID: <20061030042419.GW8394166@melbourne.sgi.com>
References: <4541BDE2.6050703@sw.ru> <45409DD5.7050306@sw.ru> <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> <19898.1161869129@redhat.com> <22562.1161945769@redhat.com> <24249.1161951081@redhat.com> <4542123E.4030309@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4542123E.4030309@sw.ru>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 06:05:50PM +0400, Vasily Averin wrote:
> 
> The proposed fix prevents this issue by using per-sb dentry LRU list. It
> provides very quickly search for the unused dentries for given super block thus
> forcing shrinking always making good progress.

We've been down this path before:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114861109717260&w=2

A lot of comments on per-sb unused dentry lists were made in
the threads associated with the above. other solutions were
found to the problem that the above patch addressed, but I don't
think any of them have made it to mainline yet. You might want
to have a bit of a read of these threads first...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
