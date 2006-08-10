Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWHJQiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWHJQiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161423AbWHJQiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:38:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22928 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161107AbWHJQiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:38:07 -0400
Date: Thu, 10 Aug 2006 18:37:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Theodore Tso <tytso@mit.edu>
cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/9] sector_t format string
In-Reply-To: <20060810153150.GB21801@thunk.org>
Message-ID: <Pine.LNX.4.64.0608101833480.6762@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
 <20060809234019.c8a730e3.akpm@osdl.org> <20060810153150.GB21801@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Aug 2006, Theodore Tso wrote:

> Ext4 will support a 48-bit blocknumber format for extents, but I do
> want to make ext4 suitable as a general purpose filesystem, and 32-bit
> systems will be around for I fear far longer than people might wish.
> So while I agree that we shouldn't go _too_ far out of our way to make
> things efficient on 32-bit systems, if it's not that much work to
> support a 32-bit sector_t, we ought to do it.
> 
> So how about a compromise?  We allow for a 32-bit sector_t in ext4,
> but we drop the SECTOR_FMT, and rely on %llu and typecasts in
> printk's.  Then the only other extra hair in the filesystem code will
> be a mount-time check to make sure we don't try to mount a large
> filesystem on system with a 32-bit sector_t.

Thanks, that's what I was hoping for. :)
Disallowing to mount large fs without CONFIG_LBD is not a real problem and 
then also truncation is not an issue anymore (except maybe for e2fsck).

bye, Roman
