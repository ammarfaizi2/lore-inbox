Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVBBRig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVBBRig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 12:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVBBRif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 12:38:35 -0500
Received: from news.suse.de ([195.135.220.2]:41660 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262643AbVBBRhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 12:37:40 -0500
Subject: Re: [RFC][PATCH 0/3] Access Control Lists for tmpfs and /dev/pts
From: Andreas Gruenbacher <agruen@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.de>
In-Reply-To: <20050202165549.GA17924@infradead.org>
References: <20050202161340.660712000@blunzn.suse.de>
	 <20050202165549.GA17924@infradead.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107365842.5712.16.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Feb 2005 18:37:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 17:55, Christoph Hellwig wrote:
> On Wed, Feb 02, 2005 at 05:13:40PM +0100, Andreas Gruenbacher wrote:
> > Here is a set of three patches which implement some general
> > infrastructure and on top of that, acls for tmpfs and /dev/pts files.
> 
> Why would you want ACLs on /dev/pts?

That's actually a good question. The patch allows to give several people
access to the same terminal, which sometimes comes in handy with tools
like screen (at least in its current version), and that's what the patch
originally was meant for. I've just talked this over this with one of
the maintainers though, and there are probably better ways than handling
this at the file permission level, like passing open file descriptors
between processes. So unless somebody comes up with a convincing
application, that patch probably should stay out.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

