Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUJ2Hjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUJ2Hjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 03:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbUJ2Hjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 03:39:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56246 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261380AbUJ2Hj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 03:39:28 -0400
Date: Fri, 29 Oct 2004 17:37:23 +1000
From: Nathan Scott <nathans@sgi.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: XFS strangeness, xfs_db out of memory
Message-ID: <20041029073723.GH1246@frodo>
References: <200410240857.31893.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410240857.31893.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 08:57:26AM +0200, Robin Rosenberg wrote:
> Hi,
> 
> I was testing a tiny script on top of xfs_fsr to show fragmentation and the 
> resultss of defragmentation.  As a result of fine tuning the output I ran the 
> script repeatedly and suddenly got error from find (unknown error 999 if my 
> memory serves me. It scrolled off the screen).
> ...
> xfs_info $dev
> xfs_db -r $dev -c "frag -v"

This is accessing the device while the filesystem is mounted,
in older kernels (like the one you have) that would cause the
above corruption error in XFS - thats resolved now.

As to the IDE error you saw, I'm not sure how fatal that is.

cheers.

-- 
Nathan
