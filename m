Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbTDBKMt>; Wed, 2 Apr 2003 05:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262960AbTDBKMt>; Wed, 2 Apr 2003 05:12:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38036 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261352AbTDBKMt>; Wed, 2 Apr 2003 05:12:49 -0500
Date: Wed, 2 Apr 2003 11:26:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Hua Zhong <hzhong@cisco.com>
cc: Christoph Rohland <cr@sap.com>, Daniel Egger <degger@fhm.edu>,
       <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <CDEDIMAGFBEBKHDJPCLDCECBDGAA.hzhong@cisco.com>
Message-ID: <Pine.LNX.4.44.0304021119400.1162-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Hua Zhong wrote:
> There is at least one case that ramfs works but tmpfs doesn't.
> 
> If you have a loopback file A, and the following will fail in 2.4:
> 
> mount -t tmpfs tmpfs /mnt/tmp
> extract file A to /mnt/tmp/A
> mount -t ext2 -o loop /mnt/tmp /mnt/loopback
> 
> You'll get "ioctl: LOOP_SET_FD: Invalid argument".
> 
> But ramfs works great.
> 
> Is this a bug or feature?

Feature: the way tmpfs allows a page to move between swap and memory
makes loopback harder to support than it is for all-in-memory ramfs.

I used to have the patches to enable loopback on tmpfs in 2.4 (well,
I still have them, but 2.4 and tmpfs have both moved on), but shifted
attention to 2.5.  One day I'll clean them up, but that day is not soon.

Hugh

