Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbVK2QDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbVK2QDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVK2QDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:03:08 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:6257 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S1751386AbVK2QDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:03:07 -0500
Date: Tue, 29 Nov 2005 10:03:02 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051129160302.GA1105271@hiwaay.net>
References: <fa.gcocno9.1lgcbap@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129050439.GB22879@thunk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Theodore Ts'o <tytso@mit.edu> said:
>This isn't actually a new idea, BTW.  Digital's advfs had storage
>pools and the ability to have a single advfs filesystem spam multiple
>filesystems, and to have multiple adv filesystems using storage pool,
>something like ten years ago.

A really nice feature of AdvFS is fileset-level snapshots.  For my Alpha
servers, I don't have to allocate disk space to snapshot storage; the
fileset uses free space within the fileset for changes while a snapshot
is active.  For my Linux servers using LVM, I have to leave a chunk of
space free in the volume group, make sure it is big enough, make sure
only one snapshot exists at a time (or make sure there's enough free
space for multiple snapshots), etc.

AdvFS is also fully integrated with TruCluster; when I started
clustering, I didn't have to change anything for most of my storage.

I will miss AdvFS when we turn off our Alphas for the last time (which
won't be far off I guess; final order date for an HP Alpha system is
less than a year away now).
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
