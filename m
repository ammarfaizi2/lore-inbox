Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTDOPp6 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTDOPp6 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:45:58 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:17304 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261705AbTDOPp5 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 11:45:57 -0400
Date: Tue, 15 Apr 2003 16:57:08 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: BUGed to death
Message-ID: <20030415155708.GB17152@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	rwhron@earthlink.net, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <20030415143024.GA10117@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415143024.GA10117@rushmore>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 10:30:24AM -0400, rwhron@earthlink.net wrote:
 > The patch below eliminates 4 BUG() calls that clearly 
 > cannot happen based on the context.

This looks bogus.

 > --- linux-2.5.67-mm2/fs/reiserfs/hashes.c.orig	2003-04-15 10:11:44.000000000 -0400
 > +++ linux-2.5.67-mm2/fs/reiserfs/hashes.c	2003-04-15 10:13:43.000000000 -0400
 > @@ -90,10 +90,6 @@
 >  
 >  	if (len >= 12)
 >  	{
 > -	    	//assert(len < 16);
 > -		if (len >= 16)
 > -		    BUG();
 > -

Imagine I pass in 20. Previously, the BUG triggers. Not any more.
Ditto the other changes.  Or am _I_ missing something ?

		Dave

