Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbULIEwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbULIEwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 23:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbULIEwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 23:52:15 -0500
Received: from waste.org ([209.173.204.2]:39589 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261452AbULIEwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 23:52:12 -0500
Date: Wed, 8 Dec 2004 20:52:07 -0800
From: Matt Mackall <mpm@selenic.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Bernard Normier <bernard@zeroc.com>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041209045207.GB12189@waste.org>
References: <006001c4d4c2$14470880$6400a8c0@centrino> <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <Pine.LNX.4.60.0412081905140.17193@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0412081905140.17193@dlang.diginsite.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 07:10:16PM -0800, David Lang wrote:
> On Tue, 7 Dec 2004, Bernard Normier wrote:
> 
> >I am just trying to generate UUIDs (without duplicates, obviously).
> >
> 
> pulling data from /dev/random or /dev/urandom will not ensure that you 
> don't have duplicates.

No, but this problem can generate duplicates as large as an SHA hash
with relative ease when it should be essentially impossible. In other
words, it works exactly wrong for UUIDs, which needs fixing.

-- 
Mathematics is the supreme nostalgia of our time.
