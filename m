Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310762AbSCHJ0D>; Fri, 8 Mar 2002 04:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310763AbSCHJZx>; Fri, 8 Mar 2002 04:25:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55771 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310762AbSCHJZi>;
	Fri, 8 Mar 2002 04:25:38 -0500
Date: Fri, 8 Mar 2002 04:25:36 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More user-space path handling cleanups
In-Reply-To: <E16jGYi-0005dq-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0203080424040.28257-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Mar 2002, Paul Menage wrote:

> 
> This patch (against 2.5.6-pre3) replaces a few instances of the
> getname()/path_lookup() combination with __user_walk(), in the same vein
> as some of the changes accompanying the path_lookup() patch that was
> included in 2.5.6-pre3.

Broken.  __user_walk() frees the temporary name it had created, leaving
nd->last.name pointing nowhere (BTW, that's how I fucked up in the first
version of patch that went into -pre3).

