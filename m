Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUDSTrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUDSTrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:47:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261779AbUDSTrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:47:18 -0400
Subject: Re: [Ext2-devel] Re: [RFC] extents,delayed allocation,mballoc for
	ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: Matt Mackall <mpm@selenic.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <m3llkyojcx.fsf@bzzz.home.net>
References: <m365c3pthi.fsf@bzzz.home.net> <20040414040101.GO1175@waste.org>
	 <m3llkyojcx.fsf@bzzz.home.net>
Content-Type: text/plain
Organization: 
Message-Id: <1082404030.2237.72.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2004 20:47:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-04-14 at 13:05, Alex Tomas wrote:

>  MM> I'm going to assume that there's no way for ext3 without extents
>  MM> support to mount such a filesystem, so I think this means changing the
>  MM> FS name. Is there a simple migration path to extents for existing filesystems?
> 
> yeah. you're right. I see no way to make it backward-compatible. in fact,
> I haven't think much about name. probably you're right again and this
> "ext3 on steroids" should have another name.

We've already got feature compatibility bits that can deal with this
sort of thing.  There are various other proposed incompatible features,
such as large inodes and dynamically placed metadata (eg. placing inode
tables into an inode "file"), too.  Rather than invent new names for
each combination of incompatible feature set, we're probably better off
just using the feature masks.

Cheers,
 Stephen


