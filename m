Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUFAN1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUFAN1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUFAN1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:27:03 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:31431 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265031AbUFAN07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:26:59 -0400
Date: Tue, 1 Jun 2004 15:26:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040601132629.GA14572@wohnheim.fh-wedel.de>
References: <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040601055616.GD15492@wohnheim.fh-wedel.de> <20040601060205.GE15492@wohnheim.fh-wedel.de> <20040601123921.GN12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040601123921.GN12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 June 2004 13:39:22 +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
>  
> > +/**
> > + * RECURSION:	100
> > + * STEP:	register_proc_table
> > + */
> 
> This is too ugly for words ;-/  Who will maintain that data, anyway?

What format do you propose?  I don't care too much.

Maintenance would get easier with less recursions, obviously. ;)

I could hack up something that will generate digests from the function
source code (through smatch or so) and put those digests into the
comments.  As long as they match, the comments remain valid.  And that
should get past lawyers, as I work on a different basis now.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
