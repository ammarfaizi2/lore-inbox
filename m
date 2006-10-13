Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWJMNlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWJMNlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWJMNlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:41:05 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:28592 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750725AbWJMNlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:41:02 -0400
Date: Fri, 13 Oct 2006 09:40:35 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ezk@cs.sunysb.edu, mhalcrow@us.ibm.com, phillip@hellewell.homeip.net
Subject: Re: [RFC/PATCH 1/2] stackfs: generic functions for obtaining hidden object
Message-ID: <20061013134035.GD3936@filer.fsl.cs.sunysb.edu>
References: <Pine.LNX.4.64.0610131615370.563@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610131615370.563@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 04:22:09PM +0300, Pekka J Enberg wrote:
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Add generic functions for obtaining the hidden object (superblock, inode,
> dentry, and dentry mount-point) in a stacked filesystem.  As fan-out 
> stacked filesystems have multiple hidden objects, we store them in a 
> statically allocated array of pointers.  The current hard-coded limit 
> STACKFS_MAX_BRANCHES is not enough for unionfs (for which users have more 
> than 100 branches).  That, however, can be fixed later for unionfs.
 
Most users have 2-3 branches, however there are few that do indeed have 100
or more branches in one Union.
 
The functions you have allow you to get the values out of the arrays, but
there are no set functions. Otherwise it looks good.

Acked-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

-- 
I think there is a world market for maybe five computers.
		- Thomas Watson, chairman of IBM, 1943.
