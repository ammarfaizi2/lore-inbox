Return-Path: <linux-kernel-owner+w=401wt.eu-S1751339AbXAIMPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbXAIMPy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 07:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbXAIMPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 07:15:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41580 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbXAIMPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 07:15:53 -0500
Date: Tue, 9 Jan 2007 13:15:52 +0100
From: Jan Kara <jack@suse.cz>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070109121552.GA1260@atrey.karlin.mff.cuni.cz>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org> <20070108231524.GA1269@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108231524.GA1269@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 08, 2007 at 11:18:52AM -0800, Andrew Morton wrote:
> > On Sun,  7 Jan 2007 23:12:53 -0500
> > "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> > 
  <snip>

> > > Any such change can cause Unionfs to oops, or stay
> > > silent and even RESULT IN DATA LOSS.
> > 
> > With a rather rough user interface ;)
> 
> That statement is meant to scare people away from modifying the lower fs :)
> I tortured unionfs quite a bit, and it can oops but it takes some effort.
  But isn't it then potential DOS? If you happen to union two filesystems
and an untrusted user has write access to both original filesystem and
the union, then you say he'd be able to produce oops? That does not
sound very secure to me... And if any secure use of unionfs requires
limitting access to the original trees, then I think it's a good reason
to implement it in unionfs itself. Just my 2 cents.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
