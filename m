Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTD1PrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbTD1PrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 11:47:10 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57537 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261178AbTD1PrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 11:47:08 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <20030423194254.A5295@infradead.org>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423191749.A4244@infradead.org>
	 <1051122958.14761.110.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423194254.A5295@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051545556.2021.50.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Apr 2003 16:59:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2003-04-23 at 19:42, Christoph Hellwig wrote:
> On Wed, Apr 23, 2003 at 02:35:59PM -0400, Stephen Smalley wrote:
> > The idea of using separate attribute names for each security module was
> > already discussed at length when I posted the original RFC, and I've
> > already made the case that this is not desirable.  Please see the
> > earlier discussion.
> 
> No.  It's not acceptable that the same ondisk structure has a different
> meaning depending on loaded modules.  If the xattrs have a different
> meaning they _must_ have a different name.

I'm not convinced --- I don't see much value in trying to preserve MAC
semantics over load/unload of different security modules, so for sanity
the important thing is just to be able to detect whether a security
xattr "belongs" to the current module or not.  That can be done with a
simple prefix in the xattr value itself.  Trying to make multiple MAC
labels coexist in different xattrs seems to have little use.

--Stephen

