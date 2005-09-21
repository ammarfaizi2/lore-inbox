Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVIUBi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVIUBi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIUBi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:38:29 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:6859 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750866AbVIUBi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:38:29 -0400
Date: Tue, 20 Sep 2005 21:38:27 -0400
From: Latchesar Ionkov <lucho@ionkov.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] v9fs-get-sb-cleanup.patch
Message-ID: <20050921013827.GA2096@ionkov.net>
References: <20050921012526.GF2008@ionkov.net> <20050921013506.GS7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921013506.GS7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 02:35:06AM +0100, Al Viro said:
> On Tue, Sep 20, 2005 at 09:25:26PM -0400, Latchesar Ionkov wrote:
> > Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
> > 
> > if error occurs while in v9fs_get_sb, some objects are freed twice -- once
> > in v9fs_get_sb, the second time when v9fs_kill_super is (indirectly
> > called).
>  
> Huh?  ->kill_sb() is *NOT* called when ->get_sb() fails.

I guess I wasn't clear. If v9fs ->get_sb fails after it called sget,
->get_sb calls deactivate_super, which calls ->kill_sb().

Thanks,
	Lucho
