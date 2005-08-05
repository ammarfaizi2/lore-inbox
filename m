Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVHEI2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVHEI2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVHEI2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:28:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:65424 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262907AbVHEI2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:28:46 -0400
Date: Fri, 5 Aug 2005 10:28:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Teigland <teigland@redhat.com>
cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
In-Reply-To: <20050805071415.GC14880@redhat.com>
Message-ID: <Pine.LNX.4.61.0508051026540.26367@yvahk01.tjqt.qr>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org>
 <20050805071415.GC14880@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The gfs2_disk_hash() function and the crc table on which it's based are a
>part of gfs2_ondisk.h: the ondisk metadata specification.  This is a bit
>unusual since gfs uses a hash table on-disk for its directory structure.
>This header, including the hash function/table, must be included by user
>space programs like fsck that want to decipher a fs, and any change to the
>function or table would effectively make the fs corrupted.  Because of
>this I think it's best for gfs to keep it's own copy as part of its ondisk
>format spec.

Tune the spec to use kernel and libcrc32 tables and bump the version number of 
the spec to e.g. GFS 2.1. That way, things transform smoothly and could go out 
eventually at some later date.



Jan Engelhardt
-- 
