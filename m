Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUAIN1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 08:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUAIN1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 08:27:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58765 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261539AbUAIN1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 08:27:33 -0500
Date: Fri, 9 Jan 2004 14:27:31 +0100
From: Jan Kara <jack@suse.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>
Subject: Re: [2.4 patch] fix CONFIG_QFMT_V2 description
Message-ID: <20040109132731.GC28922@atrey.karlin.mff.cuni.cz>
References: <20040107155940.GB11523@fs.tum.de> <20040107161110.A30210@infradead.org> <20040109022742.GA1440@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109022742.GA1440@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 07, 2004 at 04:11:10PM +0000, Christoph Hellwig wrote:
> > On Wed, Jan 07, 2004 at 04:59:40PM +0100, Adrian Bunk wrote:
> > > In 2,4, the CONFIG_QFMT_V2 short description talks about a
> > > "VFS v0 quota format". Is this really correct, or is the patch below 
> > > that uses the "Quota format v2 support" text from 2.6 instead correct?
> > 
> > I think you should ask Jan Kara instead what he prefers.  This VFS v0
> > stuff is his invention.  Personally I'm a little confused about the proper
> > naming, too.
> 
> Jan, could you check whether the patch below is correct?
  I don't have a strong opinion on this but I like the current state
slightly more. I know there's a mess that VFSv0 = quota_v2. But
currently it's at least in the state that what users (admins) see is
VFSv0 and v2 appears only in the name of kernel config options and in
the identifiers in the code. Changing VFSv0 to "v2" in kernel is no
problem but quota-tools use VFSv0 too and it's also used as an
identifier of a quota format in the options of quota tools (hence
renaming is higly unpleasant for admins). So I'm not sure that renaming
config options in kernel doesn't make things even more messy.

								Honza
