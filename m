Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUBFN4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUBFN4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:56:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12222 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265315AbUBFN4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:56:24 -0500
Date: Fri, 6 Feb 2004 13:56:23 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Werner Almesberger <wa@almesberger.net>
Cc: Andrew Morton <akpm@osdl.org>, Matt <dirtbird@ntlworld.com>,
       linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206135623.GH21151@parcelfarce.linux.theplanet.co.uk>
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org> <40235DCC.2060606@ntlworld.com> <20040206013523.394d89f1.akpm@osdl.org> <20040206105008.B18820@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206105008.B18820@almesberger.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 10:50:09AM -0300, Werner Almesberger wrote:
> Andrew Morton wrote:
> > Not unless we can think of a way in which it actually matters, thanks.
> 
> What I'm struggling with when reading that POSIX draft is to
> understand whether CLONE_FILES is appropriate or not for
> pthread_create.
> 
> If this is unspecified, the f_pos issue becomes largely academic,
> although one might argue that read() should behave either one
> way or the other.
> 
> And no, luckily, I don't have a real-life application for this
> either :-)

WTF does that have to CLONE_FILES?  Whether you share descriptor table
or get an independent copy, pointers to struct file are the same.
