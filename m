Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTKHTGx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 14:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTKHTGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 14:06:53 -0500
Received: from dp.samba.org ([66.70.73.150]:65413 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262052AbTKHTGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 14:06:51 -0500
Date: Sun, 9 Nov 2003 06:03:10 +1100
From: Anton Blanchard <anton@samba.org>
To: Martin Hicks <mort@wildopensource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Number of proc entries based on NR_CPUS ?
Message-ID: <20031108190310.GG3440@krispykreme>
References: <1068313378.685.7.camel@socrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068313378.685.7.camel@socrates>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Martin,

> Here is a patch that makes the number of /proc entries be based on
> NR_CPUS instead of just having a fixed number.  I think it is a good
> idea now that big Linux machines are starting to appear.
> 
> The proper constant and slope of increase are up for argument too.
> 
> Patch is against the latest linux-2.5 bk tree.

I think I first bumped that to 16k, that was needed on a 32way box.
At 128way my gut feeling is its 32k.

Linking the number of proc entries to the number of cpus is a bit crude
but its better than having it fixed.

FYI I think some networking people were complaining about this limit
when they create gobs of network interfaces (dummy devices?  ipsec?).
Each interface creates a bunch of /proc/sys/net entries...

Anton
