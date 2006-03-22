Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWCVIlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWCVIlA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWCVIlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:41:00 -0500
Received: from fmr17.intel.com ([134.134.136.16]:4536 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751105AbWCVIk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:40:59 -0500
Date: Wed, 22 Mar 2006 00:40:28 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Cc: Arjan van de Ven <arjan@linux.intel.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060322084027.GQ12571@goober>
References: <20060322011034.GP12571@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322011034.GP12571@goober>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 05:10:36PM -0800, Valerie Henson wrote:
> 
> The combination of the orphan inode and preallocation blocks problem
> led me to another idea: create in-memory-only allocation bitmaps for
> both inodes and blocks.  These bitmaps would track blocks and inodes
> allocated only for the life of this mount (or a file open) in memory
> rather than on disk.  I haven't implemented this yet but I think it is
> a promising approach.

As I discovered about 5 seconds after starting to implement this, this
is a terrible idea.  Hint: think about worst-case memory usage.  I am
working on porting the ext3 reservation code to ext2 instead.

-VAL
