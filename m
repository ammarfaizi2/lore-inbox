Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSKCFgJ>; Sun, 3 Nov 2002 00:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSKCFgJ>; Sun, 3 Nov 2002 00:36:09 -0500
Received: from codepoet.org ([166.70.99.138]:26297 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S261650AbSKCFgI>;
	Sun, 3 Nov 2002 00:36:08 -0500
Date: Sat, 2 Nov 2002 22:42:43 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103054243.GA19481@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu> <Pine.LNX.4.44.0211022101090.20616-100000@mooru.gurulabs.com> <20021103053109.GA19281@codepoet.org> <1036301868.31698.160.camel@thud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036301868.31698.160.camel@thud>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Nov 02, 2002 at 10:37:48PM -0700, Dax Kelson wrote:
> On Sat, 2002-11-02 at 22:31, Erik Andersen wrote:
> > On Sat Nov 02, 2002 at 09:04:07PM -0700, Dax Kelson wrote:
> > >
> > > 
> > > Any thoughts on how /usr/bin/(rpm|dpkg) copes with setting up the binding
> > > when installing a package?
> > 
> > postint script
> 
> Sure, but editing /etc/fstab from postint is messy, potentially
> dangerous, and could possibly collide with someone doing a manual edit
> of /etc/fstab.
> 
> Maybe we need a /etc/fstab.d/ directory and teach /bin/mount about it.

Or have an /etc/fstab.d/ directory plus have an update-fstab
script that collates the entries in that directory and stuffs the
result into /etc/fstab, and have update-fstab called from the postint
script.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
