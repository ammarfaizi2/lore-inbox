Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVDZVCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVDZVCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVDZVCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 17:02:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:20165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261776AbVDZVCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 17:02:03 -0400
Date: Tue, 26 Apr 2005 13:56:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: mason@suse.com, torvalds@osdl.org, mike.taht@timesys.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
Message-Id: <20050426135606.7b21a2e2.akpm@osdl.org>
In-Reply-To: <aec7e5c305042609231a5d3f0@mail.gmail.com>
References: <20050426004111.GI21897@waste.org>
	<200504260713.26020.mason@suse.com>
	<aec7e5c305042608095731d571@mail.gmail.com>
	<200504261138.46339.mason@suse.com>
	<aec7e5c305042609231a5d3f0@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> wrote:
>
> My primitive guess is that it was because
>  the ext3 journal became full.

The default ext3 journal size is inappropriately small, btw.  Normally you
should manually make it 128M or so, rather than 32M.  Unless you have a
small amount of memory and/or a large number of filesystems, in which case
there might be problems with pinned memory.

Mounting as ext2 is a useful technique for determining whether the fs is
getting in the way.

