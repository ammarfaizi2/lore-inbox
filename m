Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTEDNMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 09:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTEDNMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 09:12:47 -0400
Received: from iole.cs.brandeis.edu ([129.64.3.240]:57997 "EHLO
	iole.cs.brandeis.edu") by vger.kernel.org with ESMTP
	id S263595AbTEDNMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 09:12:46 -0400
Date: Sun, 4 May 2003 09:25:14 -0400 (EDT)
From: Mikhail Kruk <meshko@cs.brandeis.edu>
To: Jamie Lokier <jamie@shareable.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: fcntl file locking and pthreads
In-Reply-To: <20030504125845.GA32087@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.33.0305040922020.32427-100000@iole.cs.brandeis.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mikhail Kruk wrote:
> > on 2.4 kernels fcntl-based file locking does not work with 
> > clone-based threads as expected (by me): two threads of the same process 
> > can acquire exclusive lock on a file at the same time.
> > flock()-based locks work as expected, i.e. only one thread can have an 
> > exclusive lock at a time.
> 
> Is this true even when _not_ setting CLONE_FILES?

CLONE_FILES is an argument to clone(), I'm using pthreads and I don't 
know if LinuxThreads implementation of pthreads gives me control of 
how clone is called. Anyway, if I understand what CLONE_FILES does, 
it should be given to clone, because threads do have to be able to share file 
descriptors, probably. But not the locks!

