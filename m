Return-Path: <linux-kernel-owner+w=401wt.eu-S1751252AbXAIJxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbXAIJxy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbXAIJxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:53:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43378 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbXAIJxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:53:52 -0500
Date: Tue, 9 Jan 2007 09:53:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Erez Zadok <ezk@cs.sunysb.edu>
Cc: Andrew Morton <akpm@osdl.org>, Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070109095345.GB12406@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
	Shaya Potter <spotter@cs.columbia.edu>,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@ftp.linux.org.uk, torvalds@osdl.org, mhalcrow@us.ibm.com,
	David Quigley <dquigley@cs.sunysb.edu>
References: <20070108140224.3a814b7d.akpm@osdl.org> <200701090003.l0903Z2O017720@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701090003.l0903Z2O017720@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 07:03:35PM -0500, Erez Zadok wrote:
> However, I must caution that a file system like ecryptfs is very different
> from Unionfs, the latter being a fan-out file system---and both have very
> different goals.  The common code between the two file systems, at this
> stage, is not much (and we've already extracted some of it into the "stackfs
> layer").

I think that's an very important point.  We have a chance to get that
non-fanout filesystems right quite easily - something I wished that would
have been done before the ecryptfs merge - while getting fan-out stackable
filesystems is a really hard task.  In addition to that I know exactly
one fan-out stackable filesystem that is posisbly useful, which is unionfs.
Because of that I'm much more inclined to add VFS asistance for this
particular problem (unioning) instead of adding complex infrastructure
to solve a general problem that people don't benefit from.

