Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbUCMWOu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbUCMWOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:14:50 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:41521 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263208AbUCMWOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:14:44 -0500
Date: Sat, 13 Mar 2004 23:17:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040313221741.GA1998@mars.ravnborg.org>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313173331.GO20174@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 11:33:32AM -0600, Matt Mackall wrote:
> But I think it's fair to say that new features that are on by default
> are in fact bloat in some sense.

You cannot do any metric based on defconfig, since per. definition defconfig is what
suits Linus's current i386 PC best.
If you really want to do a proper metric do something like the follwoing:

make allnoconfig
Use some sed/awk magic to enable the options you are interested in
- Networking
- procfs?
- ext2
- One net driver
- A bit more which make sense
make oldconfig

This should result in a reliable config for code metrics.
You just have to inspect that noone of your manually added options
are no longer recognized (grep for warnings in output).

If you get this working it would be nice to see the evolution starting from 2.6.1 and
onwards in line with John Cherrys compile stats.

	Sam
