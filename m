Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUCOHsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 02:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbUCOHsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 02:48:09 -0500
Received: from mail.shareable.org ([81.29.64.88]:16780 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262020AbUCOHsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 02:48:07 -0500
Date: Mon, 15 Mar 2004 07:45:58 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Sytse Wielinga <s.b.wielinga@student.utwente.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for testing] cow behaviour for hard links
Message-ID: <20040315074558.GA7188@mail.shareable.org>
References: <20040310193429.GB4589@wohnheim.fh-wedel.de> <200403121849.03505.s.b.wielinga@student.utwente.nl> <20040312182912.GB7087@wohnheim.fh-wedel.de> <20040313134330.GC3352@openzaurus.ucw.cz> <20040313194827.GA4748@wohnheim.fh-wedel.de> <20040313210305.GB549@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313210305.GB549@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Or did you mean the problem of tar backups growing *much* larger than
> > the real filesystem?  Yes, tar becomes useless for backups then. :)
> 
> Yep, this is what I meant.

A different but related problem: rsync cannot backup my kernel
development directory from one hard disk to another, because it
contains lots of kernel trees mostly hard linked to each other.  rsync
falls over, trying to keep track of the roughly half a million links.

You might see similar problems trying to backup a strongly "copyfile"'d
filesystems.

-- Jamie
