Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVHYQ0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVHYQ0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVHYQ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:26:23 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:46836 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932279AbVHYQ0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:26:22 -0400
Subject: Re: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg Kroah <greg@kroah.com>, Kurt Garloff <garloff@suse.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050825162101.GU7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain>
	 <20050825012150.490797000@localhost.localdomain>
	 <20050825143807.GA8590@sergelap.austin.ibm.com>
	 <1124982836.3873.78.camel@moss-spartans.epoch.ncsc.mil>
	 <20050825162101.GU7762@shell0.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 25 Aug 2005 12:23:56 -0400
Message-Id: <1124987036.3873.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 09:21 -0700, Chris Wright wrote:
> * Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> > On Thu, 2005-08-25 at 09:38 -0500, serue@us.ibm.com wrote:
> > > Ok, with the attached patch SELinux seems to work correctly.  You'll
> > > probably want to make it a little prettier  :)  Note I have NOT ran the
> > > ltp tests for correctness.  I'll do some performance runs, though
> > > unfortunately can't do so on ppc right now.
> > 
> > Note that the selinux tests there _only_ test the SELinux checking.  So
> > if these changes interfere with proper stacking of SELinux with
> > capabilities, that won't show up there.  
> 
> Sorry, I'm not parsing that?

e.g. if secondary_ops->capable is null, the SELinux tests aren't going
to show that, because they will still see that the SELinux permission
checks are working correctly.  They only test failure/success for the
SELinux permission checks, not for the capability checks, so if you
unhook capabilities, they won't notice.

-- 
Stephen Smalley
National Security Agency

