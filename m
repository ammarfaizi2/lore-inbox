Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbREOVV6>; Tue, 15 May 2001 17:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbREOVVs>; Tue, 15 May 2001 17:21:48 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:6668 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261547AbREOVVe>; Tue, 15 May 2001 17:21:34 -0400
Date: Tue, 15 May 2001 23:20:52 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Inodes
Message-ID: <20010515232052.A31209@artax.karlin.mff.cuni.cz>
In-Reply-To: <20010514065650.11112.qmail@nw176.netaddress.usa.net> <200105141957.f4EJvWJ42261@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105141957.f4EJvWJ42261@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, May 14, 2001 at 03:57:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Blesson Paul writes:
> 
> > This is an another doubt related to VFS. I want to know
> > wheather all files are assigned their inode number at the
> > mounting time itself or inodes are assigned to files upon
> > accessing only
> 
> That would depend on what type of filesystem you use.
> For ext2, inode numbers are assigned at file creation.
> For vfat, inode numbers are assigned as needed, and
> forgotten when not needed.

I think using pointers to inode structures as inode numbers might be
an optimal solution. Since inode structure is long, it can even be
shifted few bits left if some special numbers are needed. Uniqueness
check should be added for 64-bit platforms, but it should work without
(kernel memory is not large enough for the nuber to wrap).

Bulb
