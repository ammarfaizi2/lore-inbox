Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWJGRD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWJGRD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWJGRD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:03:57 -0400
Received: from ns1.mvista.com ([63.81.120.158]:29422 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751260AbWJGRD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:03:56 -0400
Subject: Re: [PATCH 2 of 23] lookup_one_len_nd - lookup_one_len with
	nameidata argument
From: Daniel Walker <dwalker@mvista.com>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk
In-Reply-To: <3104d077379c19c98510.1160197641@thor.fsl.cs.sunysb.edu>
References: <3104d077379c19c98510.1160197641@thor.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 10:03:53 -0700
Message-Id: <1160240633.21411.6.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-07 at 01:07 -0400, Josef Jeff Sipek wrote:

> -struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
> +struct dentry * lookup_one_len_nd(const char *name, struct dentry * base, int len, struct nameidata *nd)

> -extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
> +extern struct dentry * lookup_one_len_nd(const char *, struct dentry *, int, struct nameidata *);
> +
> +/* SMP-safe */
> +static inline struct dentry *lookup_one_len(const char *name, struct dentry *dir, int len)


These lines are all too long . Should max out at 80 characters.

Daniel

