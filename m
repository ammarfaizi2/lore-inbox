Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUDNMGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbUDNMGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:06:16 -0400
Received: from [82.138.8.106] ([82.138.8.106]:44533 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S264058AbUDNMGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:06:12 -0400
X-Comment-To: Matt Mackall
To: Matt Mackall <mpm@selenic.com>
Cc: alex@clusterfs.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] extents,delayed allocation,mballoc for ext3
References: <m365c3pthi.fsf@bzzz.home.net> <20040414040101.GO1175@waste.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Wed, 14 Apr 2004 16:05:18 +0400
In-Reply-To: <20040414040101.GO1175@waste.org> (Matt Mackall's message of
 "Tue, 13 Apr 2004 23:01:02 -0500")
Message-ID: <m3llkyojcx.fsf@bzzz.home.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Matt Mackall (MM) writes:

 MM> I'm going to assume that there's no way for ext3 without extents
 MM> support to mount such a filesystem, so I think this means changing the
 MM> FS name. Is there a simple migration path to extents for existing filesystems?

yeah. you're right. I see no way to make it backward-compatible. in fact,
I haven't think much about name. probably you're right again and this
"ext3 on steroids" should have another name.
 
 MM> Similar questions here.

no. this one is backward-compatible and usual ext3 will run ok.
btw, I think it possible to implement few routines that could allow
to exploit delayed allocation and multiblock allocator patches w/o
introducing extents. the most visible effect of the extents is much
faster truncate.

 MM> You might also mention that on-disk format issues such as endian
 MM> layout are not finalized.

yep. thanks for notice.

