Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUENSAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUENSAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUENSAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:00:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:42440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261993AbUENSAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:00:16 -0400
Date: Fri, 14 May 2004 11:00:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       luto@myrealbox.com, Chris Wright <chrisw@osdl.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] capabilites, take 2
Message-ID: <20040514110009.T21045@build.pdx.osdl.net>
References: <1084536213.951.615.camel@cube> <1084548061.17741.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1084548061.17741.119.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Fri, May 14, 2004 at 11:21:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Fri, 2004-05-14 at 08:03, Albert Cahalan wrote:
> > This would be an excellent time to reconsider how capabilities
> > are assigned to bits. You're breaking things anyway; you might
> > as well do all the breaking at once. I want local-use bits so
> > that the print queue management access isn't by magic UID/GID.
> > We haven't escaped UID-as-priv if server apps and setuid apps
> > are still making UID-based access control decisions.
> 
> Capabilities are a broken model for privilege management; try RBAC/TE
> instead.  http://www.securecomputing.com/pdf/secureos.pdf has notes
> about the history and comparison of capabilities vs. TE.
> 
> Instead of adding new capability bits, replace capable() calls with LSM
> hook calls that offer you finer granularity both in operation and in
> object-based decisions, and then use a security module like SELinux to
> map that to actual permission checks.  SELinux provides a framework for
> defining security classes and permissions, including both definitions
> used by the kernel and definitions used by userspace policy enforcers
> (ala security-enhanced X).

exactly!

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
