Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbTF3ALR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 20:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbTF3ALR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 20:11:17 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:35521 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S265714AbTF3ALL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 20:11:11 -0400
Date: Sun, 29 Jun 2003 20:25:28 -0400
To: rmoser <mlmoser@comcast.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030630002527.GA26094@delft.aura.cs.cmu.edu>
Mail-Followup-To: rmoser <mlmoser@comcast.net>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net> <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk> <200306291629450990.023BC35E@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306291629450990.023BC35E@smtp.comcast.net>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 04:29:45PM -0400, rmoser wrote:
> NO!  You're not getting the point at all!
> 
> You don't need a pair!  If you have 10 filesystems, you need 10 sets of
> code in each direction, not 90.  You convert from the data/metadata set
> in the first filesystem to a self-contained atom, and then back from the
> atom to the data/metadata set in the new filesystem.  The atom is object
> oriented, so anything that can't be moved over--like ACLs or Reiser4's
> extended attributes that nobody else has, or permissions if converting to
> vfat--is just lost.  Note that if the data has an attribute like "Compressed"
> or "encrypted", it is expanded/decrypted and thus brought back to its
> natural form before being stuffed into an atom.

I typically call that 'tar' and it works great whenever I want to
convert from one filesystem to another. I just haven't got a clue why
you want to implement tar (or cpio) in the kernel as the userspace
implementation is already pretty usable.

Jan

