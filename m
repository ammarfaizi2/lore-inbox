Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422813AbWJaGye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbWJaGye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWJaGye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:54:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:64719 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422813AbWJaGyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:54:33 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <4546EF3B.1090503@google.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	 <45461977.3020201@shadowen.org> <45461E74.1040408@google.com>
	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
	 <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net>  <4546EF3B.1090503@google.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 07:54:02 +0100
Message-Id: <1162277642.5970.4.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 22:37 -0800, Martin J. Bligh wrote:
> Mike Galbraith wrote:
> > On Mon, 2006-10-30 at 21:14 +0100, Cornelia Huck wrote:
> > 
> >> Maybe the initscripts have problems coping with the new layout
> >> (symlinks instead of real devices)?
> > 
> > SuSE's /sbin/getcfg for one uses libsysfs, which apparently doesn't
> > follow symlinks (bounces off symlink and does nutty stuff instead).  If
> > any of the boxen you're having troubles with use libsysfs in their init
> > stuff, that's likely the problem.
> 
> If that is what's happening, then the problem is breaking previously
> working boxes by changing a userspace API. I don't know exactly which
> patch broke it, but reverting all Greg's patches (except USB) from
> -mm fixes the issue.

I just straced /sbin/getcfg again, and confirmed that that is indeed
what is still happening here.  It's a known issue (for SuSE at least).

	-Mike

