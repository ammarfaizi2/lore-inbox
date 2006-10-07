Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWJGSXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWJGSXR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWJGSXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:23:17 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54225 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751238AbWJGSXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:23:16 -0400
Date: Sat, 7 Oct 2006 14:23:01 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 2 of 23] lookup_one_len_nd - lookup_one_len with nameidata argument
Message-ID: <20061007182301.GA25352@filer.fsl.cs.sunysb.edu>
References: <3104d077379c19c98510.1160197641@thor.fsl.cs.sunysb.edu> <1160240633.21411.6.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160240633.21411.6.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 10:03:53AM -0700, Daniel Walker wrote:
> On Sat, 2006-10-07 at 01:07 -0400, Josef Jeff Sipek wrote:
> 
> > -struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
> > +struct dentry * lookup_one_len_nd(const char *name, struct dentry * base, int len, struct nameidata *nd)
> 
> > -extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
> > +extern struct dentry * lookup_one_len_nd(const char *, struct dentry *, int, struct nameidata *);
> > +
> > +/* SMP-safe */
> > +static inline struct dentry *lookup_one_len(const char *name, struct dentry *dir, int len)
> 
> 
> These lines are all too long . Should max out at 80 characters.

A large portion of that file has lines >80 chars. I just kept it consistent.

Josef 'Jeff' Sipek.

-- 
Computer Science is no more about computers than astronomy is about
telescopes.
		- Edsger Dijkstra
