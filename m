Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUCOK1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 05:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUCOK1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 05:27:17 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:47810 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262528AbUCOK1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 05:27:16 -0500
Date: Mon, 15 Mar 2004 11:27:04 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Sytse Wielinga <s.b.wielinga@student.utwente.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040315102704.GA16615@wohnheim.fh-wedel.de>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de> <200403121849.03505.s.b.wielinga@student.utwente.nl> <20040312182912.GB7087@wohnheim.fh-wedel.de> <20040313134330.GC3352@openzaurus.ucw.cz> <20040313194827.GA4748@wohnheim.fh-wedel.de> <20040313210305.GB549@elf.ucw.cz> <20040315074558.GA7188@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040315074558.GA7188@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 March 2004 07:45:58 +0000, Jamie Lokier wrote:
> Pavel Machek wrote:
> > > Or did you mean the problem of tar backups growing *much* larger than
> > > the real filesystem?  Yes, tar becomes useless for backups then. :)
> > 
> > Yep, this is what I meant.
> 
> A different but related problem: rsync cannot backup my kernel
> development directory from one hard disk to another, because it
> contains lots of kernel trees mostly hard linked to each other.  rsync
> falls over, trying to keep track of the roughly half a million links.
> 
> You might see similar problems trying to backup a strongly "copyfile"'d
> filesystems.

And both are easily fixable, if you don't mind using 16 bytes of RAM
per inode.  At least for rsync this should be a piece of cake compared
to the amount of memory already used. :)

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
