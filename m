Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263308AbVBDI0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbVBDI0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 03:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVBDI0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 03:26:34 -0500
Received: from aun.it.uu.se ([130.238.12.36]:44771 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263308AbVBDI0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 03:26:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.12681.98586.426731@alkaid.it.uu.se>
Date: Fri, 4 Feb 2005 09:25:45 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Mikael Pettersson <mikpe@user.it.uu.se>, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 extended attributes refcounting wrong?
In-Reply-To: <1107473817.2058.172.camel@sisko.sctweedie.blueyonder.co.uk>
References: <16898.43219.133783.439910@alkaid.it.uu.se>
	<1107473817.2058.172.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie writes:
 > Hi,
 > 
 > On Thu, 2005-02-03 at 22:42, Mikael Pettersson wrote:
 > > I believe there is some accounting error in the ext3 code
 > > for the case when CONFIG_EXT3_FS_XATTR is not selected.
 > > 
 > > Whenever any one of my development boxes triggers an fsck
 > > at boot because some file system, usually /, has been mounted
 > > sufficiently many times, an inconsistency error occurs
 > 
 > In which kernel(s) exactly?  There was a fix for that applied fairly
 > recently upstream.

I've been seeing this over the last couple of months, with
(at least) 2.4.28 and newer, and 2.6.9 and newer standard kernels.
But since I dual boot and switch kernels often, I can't point
at any given kernel or kernel series as being the culprit.

How recent was that fix? Maybe I'm seeing the aftereffects of
pre-fix corruption?

 > > Extended attribute block N has reference count M, should be M'.
 > 
 > > This occurs on all my boxes, with different CPUs (x86/x86-64/ppc)
 > > and different chipsets (Intel, Promise, VIA, Apple), and basically
 > > the only commonalities are:
 > > - they dual boot the most recent 2.4 and 2.6 kernels, and I switch often
 > > - all file systems are ext3
 > > - all XATTR stuff is disabled
 > 
 > I'm not sure how you get this if all xattr stuff is disabled!  Are you
 > sure you're not using SELinux or ACLs, for example?

Absolutely. I use no xattrs, ACLs, or SELinux at all, and I always
disable those features in my kernels.

/Mikael
