Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbUDPSy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbUDPSy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:54:58 -0400
Received: from ns.suse.de ([195.135.220.2]:31433 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263599AbUDPSyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:54:54 -0400
Subject: Re: [PATCH] reiserfs v3 fixes and features
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com
In-Reply-To: <1081989006.27614.110.camel@watt.suse.com>
References: <1081274618.30828.30.camel@watt.suse.com>
	 <1081989006.27614.110.camel@watt.suse.com>
Content-Type: text/plain
Message-Id: <1082141666.27614.1448.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 14:54:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

I've uploaded some new code to:

ftp.suse.com/pub/people/mason/patches/reiserfs/2.6.5-mm6

Only reiserfs-group-alloc-9 has changed.

preallocation now enforces minimum allocations too, which cuts down on
fragmentation when applications send small writes.

The mount options are slightly different.  mount -o packing_groups
changed to mount -o alloc=packing_groups.  This makes the new options
more consistent and easier to control via remount and such.

More importantly, the default has changed too.  Once you apply
reiserfs-group-alloc-9, the default is:

mount -o alloc=skip_busy:dirid_groups:packing_groups

If you want the old default:

mount -o alloc=skip_busy

Both reiserfs-group-alloc-9 and reiserfs-search-reada-5 should be stable
now, at least I haven't been able to trigger problems with them in -suse
or -mm.

-chris


