Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSGHCz1>; Sun, 7 Jul 2002 22:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSGHCz0>; Sun, 7 Jul 2002 22:55:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11154 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316753AbSGHCzZ>;
	Sun, 7 Jul 2002 22:55:25 -0400
Date: Sun, 7 Jul 2002 22:58:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Wilcox <willy@debian.org>
cc: Dave Hansen <haveblue@us.ibm.com>, Oliver Neukum <oliver@neukum.name>,
       Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
In-Reply-To: <20020708033409.P27706@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0207072255020.24900-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jul 2002, Matthew Wilcox wrote:

> one struct file per open(), yes.  however, fork() shares a struct file,
> as does unix domain fd passing.  so we need protection between different
> processes.  there's some pretty good reasons to want to use a semaphore
> to protect the struct file (see fasync code.. bleugh).

??? What exactly do you want to protect there?

ObAnotherQuestion: no, new_inode() doesn't need BKL.

