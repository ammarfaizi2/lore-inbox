Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161252AbWALUnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbWALUnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWALUnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:43:40 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:29265 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161252AbWALUnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:43:40 -0500
Date: Thu, 12 Jan 2006 12:43:36 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [XFS] Do not inherit properties for the quota inodes from the root inode.
Message-ID: <20060112204336.GA20248@taniwha.stupidest.org>
References: <200601121815.k0CIFYBU024320@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601121815.k0CIFYBU024320@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 10:15:34AM -0800, Linux Kernel Mailing List wrote:
> tree 589ad79019067e1b82006bacf6c10d1d717a46dc
> parent 4ef19dddbaf2f24e492c18112fd8a04ce116daca
> author Nathan Scott <nathans@sgi.com> Wed, 11 Jan 2006 15:27:50 +1100
> committer Nathan Scott <nathans@sgi.com> Wed, 11 Jan 2006 15:27:50 +1100
>
> [XFS] Do not inherit properties for the quota inodes from the root inode.

lots of whitespace changes... :)

>
> -	if ((error = xfs_dir_ialloc(&tp, mp->m_rootip, S_IFREG, 1, 0,
> +	if ((error = xfs_dir_ialloc(&tp, &zeroino, S_IFREG, 1, 0,
>  				   &zerocr, 0, 1, ip, &committed))) {
>  		xfs_trans_cancel(tp, XFS_TRANS_RELEASE_LOG_RES |
>  				 XFS_TRANS_ABORT);

why would you want to do this at all?

