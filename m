Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTFKXC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTFKXC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:02:56 -0400
Received: from pat.uio.no ([129.240.130.16]:10483 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264537AbTFKXCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:02:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16103.47167.69772.316938@charged.uio.no>
Date: Thu, 12 Jun 2003 01:16:15 +0200
To: Frank Cusack <fcusack@fcusack.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
In-Reply-To: <20030611152436.A3241@google.com>
References: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com>
	<1055352127.2419.25.camel@dhcp22.swansea.linux.org.uk>
	<16103.26865.361044.360120@charged.uio.no>
	<16103.29804.198545.680701@charged.uio.no>
	<20030611152436.A3241@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > On Wed, Jun 11, 2003 at 08:26:52PM +0200, Trond Myklebust
     > wrote:
    >> diff -u --recursive --new-file linux-2.4.21-rc6/fs/namei.c
    >> linux/fs/namei.c
    >> --- linux-2.4.21-rc6/fs/namei.c 2002-12-30 09:39:54.000000000
    >>     -0800
    >> +++ linux/fs/namei.c 2003-06-11 11:16:49.000000000 -0700
    >> @@ -633,7 +633,8 @@
    >> * Check the cached dentry for staleness.
    >> */ dentry = nd->dentry;
    >> - if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {

     > Doesn't the above simply always revalidate?

That's the whole problem in a nutshell. Read the thread...

Cheers,
  Trond
