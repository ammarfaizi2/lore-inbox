Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUA3Vw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUA3Vw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:52:26 -0500
Received: from [66.35.79.110] ([66.35.79.110]:34722 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S264359AbUA3VwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:52:25 -0500
Date: Fri, 30 Jan 2004 13:52:09 -0800
From: Tim Hockin <thockin@hockin.org>
To: John Stoffel <stoffel@lucent.com>
Cc: Andrew Morton <akpm@osdl.org>, thockin@sun.com, arjanv@redhat.com,
       thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040130215209.GA29010@hockin.org>
References: <20040130014108.09c964fd.akpm@osdl.org> <1075489136.5995.30.camel@moria.arnor.net> <200401302007.26333.thomas.schlichter@web.de> <1075490624.4272.7.camel@laptop.fenrus.com> <20040130114701.18aec4e8.akpm@osdl.org> <20040130201731.GY9155@sun.com> <20040130123301.70009427.akpm@osdl.org> <16410.51656.221208.976055@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16410.51656.221208.976055@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 04:16:56PM -0500, John Stoffel wrote:
> Andrew> static long do_setgroups(int gidsetsize, gid_t __user *user_grouplist,
> Andrew> 			gid_t *kern_grouplist)
> Andrew> {
> Andrew> 	gid_t groups[NGROUPS];
> 
> Call me stupid, but what if we accept the patches to increase the
> number of groups, won't that make this array be huge potentially?
> Shouldn't we instead do a kmalloc() using current->ngroups instead?

One of the things you CAN'T do anymore is an array of NGROUPS.  That is why
struct group_info is there. Andrew's suggestion was a sketch, not a patch :)
