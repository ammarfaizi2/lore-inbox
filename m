Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVAGVtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVAGVtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVAGVsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:48:01 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:29446 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261647AbVAGVqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:46:13 -0500
Date: Fri, 7 Jan 2005 22:45:48 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Thayne Harbaugh <tharbaugh@lnxi.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       lkml <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: MS_NOUSER and rootfs
Message-ID: <20050107214548.GB6052@pclin040.win.tue.nl>
References: <1105024095.15293.74.camel@tubarao> <200501071932.35184.vda@port.imtp.ilyichevsk.odessa.ua> <1105131212.18437.15.camel@tubarao>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105131212.18437.15.camel@tubarao>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 01:53:32PM -0700, Thayne Harbaugh wrote:
> On Fri, 2005-01-07 at 19:32 +0200, Denis Vlasenko wrote:
> > On Thursday 06 January 2005 17:08, Thayne Harbaugh wrote:
> > > What is the purpose of the MS_NOUSER flag serve and why is it set on
> > > rootfs?

Some random docs say

The <tt>FS_NOMOUNT</tt> flag says that this filesystem must never
be mounted from userland, but is used only kernel-internally.
This flag was introduced in 2.3.99-pre7 and disappeared in Linux 2.5.22.
This was used, for example, for pipefs, the implementation of Unix pipes
using a kernel-internal filesystem (see <tt>fs/pipe.c</tt>).
Even though the flag has disappeared, the concept remains,
and is now represented by the MS_NOUSER flag.

> There isn't a description as to what the intention is for MS_NOUSER and
> why it should be applied to rootfs.  I'm looking for some education as
> to what it does so I can work out the details as to why it's used in
> graft_tree(), rootfs_get_sb() and shmem.c.
