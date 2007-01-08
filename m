Return-Path: <linux-kernel-owner+w=401wt.eu-S932108AbXAHVdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbXAHVdh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbXAHVdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:33:37 -0500
Received: from cs.columbia.edu ([128.59.16.20]:37361 "EHLO cs.columbia.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108AbXAHVdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:33:35 -0500
Subject: Re: [PATCH 01/24] Unionfs: Documentation
From: Shaya Potter <spotter@cs.columbia.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <Pine.LNX.4.61.0701082122460.23737@yvahk01.tjqt.qr>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	 <1168229596875-git-send-email-jsipek@cs.sunysb.edu>
	 <20070108111852.ee156a90.akpm@osdl.org>
	 <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu>
	 <Pine.LNX.4.61.0701082122460.23737@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 16:32:44 -0500
Message-Id: <1168291964.9853.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter2.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 21:24 +0100, Jan Engelhardt wrote:
> On Jan 8 2007 14:43, Shaya Potter wrote:
> > On Mon, 8 Jan 2007, Andrew Morton wrote:
> >> On Sun,  7 Jan 2007 23:12:53 -0500
> >> "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> >> 
> >> > +Modifying a Unionfs branch directly, while the union is
> >> > +mounted, is currently unsupported.
> >> 
> >> Does this mean that if I have /a/b/ and /c/d/ unionised under
> >> /mnt/union, I am not allowed to alter anything under /a/b/
> >> and /c/d/?  That I may only alter stuff under /mnt/union?
> >> 
> >> If so, that sounds like a significant limitation.
> >
> > haven't we been through this?  It's the same thing as
> > modifying a block device while a file system is using it. 
> > Now, when unionfs gets confused, it shouldn't oops, but would
> > one expect ext3 to allow one to modify its backing store while
> > its using it?
> 
> (Blunt counter-example: Modifying the underlying filesystem of
> an NFS import does not break. But I agree with Shaya.)
> 
> Well it was suggested to make /a/b and /c/d read-only while the
> union is mounted, using a ro bind mount, what about it? (To
> catch unwanted tampering with the lowlevels)

not quite true.   Run a program on an NFS root based system, modify the
files it has mmaped (on the NFS server).  Do you expect the program to
behave correctly?  Locally, you wouldn't be able to modify it (you would
have to move it away and put a new copy in its place), I could be wrong,
but I don't think that limitation exists if doing it with NFS.

