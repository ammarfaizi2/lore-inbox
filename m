Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUCRGsD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 01:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbUCRGsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 01:48:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45985 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262428AbUCRGsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 01:48:00 -0500
Date: Thu, 18 Mar 2004 07:47:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Zaitsev <peter@mysql.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040318064757.GA1072@suse.de>
References: <1079572101.2748.711.camel@abyss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079572101.2748.711.camel@abyss.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2004, Peter Zaitsev wrote:
> Hello,
> 
> I'm wondering is there any way in Linux to do proper fsync(), which
> makes sure data is written to the disk.
> 
> Currently on IDE devices one can see, fsync() only flushes data to the
> drive cache which is not enough for ACID guaranties database server must
> give. 
> 
> There is solution just to disable drive write cache, but it seems to
> slowdown performance way to much.

Chris and I have working real fsync() with the barrier patches. I'll
clean it up and post a patch for vanilla 2.6.5-rc today.

-- 
Jens Axboe

