Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUFIAM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUFIAM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 20:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUFIAM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 20:12:59 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:27824 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265463AbUFIAMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 20:12:49 -0400
Date: Wed, 9 Jun 2004 10:12:44 +1000
From: Nathan Scott <nathans@sgi.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.26 JFS: cannot mount
Message-ID: <20040609101244.G1200131@wobbly.melbourne.sgi.com>
References: <20040608195610.GA4757@merlin.emma.line.org> <20040608201446.GA13764@merlin.emma.line.org> <1086727014.26567.20.camel@shaggy.austin.ibm.com> <20040608223528.GA13241@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040608223528.GA13241@merlin.emma.line.org>; from matthias.andree@gmx.de on Wed, Jun 09, 2004 at 12:35:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 12:35:28AM +0200, Matthias Andree wrote:
> On Tue, 08 Jun 2004, Dave Kleikamp wrote:
> 
> > No, all of the code to replay the journal is in user space.  JFS does
> > allow a read-only mount when the superblock is dirty.  This allows
> > fsck.jfs to replay the journal while the root is mounted read-only.  /
> > can then be remounted rw after fsck runs.
> 
> So was the mount was refused because a) the read-only
> option was missing while b) the file system needed a journal replay?
> 
> Interesting difference. XFS insists on replaying the log in kernel space
> (user space can only zero the log),

FWIW, all of the log replay code is there in userspace, so it
should just be a "simple matter of programming" to implement
this for XFS (noone has ever done so though, and its never
really been a priority for us).

cheers.

-- 
Nathan
