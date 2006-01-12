Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161281AbWALVPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbWALVPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161296AbWALVPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:15:48 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:7655 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161281AbWALVPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:15:47 -0500
Date: Fri, 13 Jan 2006 08:15:44 +1100
From: Nathan Scott <nathans@sgi.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [XFS] Do not inherit properties for the quota inodes from the root inode.
Message-ID: <20060113081543.A8335102@wobbly.melbourne.sgi.com>
References: <200601121815.k0CIFYBU024320@hera.kernel.org> <20060112204336.GA20248@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060112204336.GA20248@taniwha.stupidest.org>; from cw@f00f.org on Thu, Jan 12, 2006 at 12:43:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Thu, Jan 12, 2006 at 12:43:36PM -0800, Chris Wedgwood wrote:
> > [XFS] Do not inherit properties for the quota inodes from the root inode.
> 
> lots of whitespace changes... :)

If by "lots" you mean "one line", then yes!

> >
> > -	if ((error = xfs_dir_ialloc(&tp, mp->m_rootip, S_IFREG, 1, 0,
> > +	if ((error = xfs_dir_ialloc(&tp, &zeroino, S_IFREG, 1, 0,
> >  				   &zerocr, 0, 1, ip, &committed))) {
> >  		xfs_trans_cancel(tp, XFS_TRANS_RELEASE_LOG_RES |
> >  				 XFS_TRANS_ABORT);
> 
> why would you want to do this at all?

I'm not sure what you're asking?  There are things we do not
want to inherit from the root inode (certain inode flags in
particular) when the quota inodes are being created... does
that help?

cheers.

-- 
Nathan
