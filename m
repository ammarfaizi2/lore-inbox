Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUCNVDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 16:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUCNVDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 16:03:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:10154 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261610AbUCNVDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 16:03:45 -0500
Subject: Re: Bloat report 2.6.3 -> 2.6.4
From: John Cherry <cherry@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Matt Mackall <mpm@selenic.com>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040313221741.GA1998@mars.ravnborg.org>
References: <20040312204458.GJ20174@waste.org>
	 <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org>
	 <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org>
	 <20040313221741.GA1998@mars.ravnborg.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079298197.3889.41.camel@lightning>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Mar 2004 13:03:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 14:17, Sam Ravnborg wrote:
> On Sat, Mar 13, 2004 at 11:33:32AM -0600, Matt Mackall wrote:
> > But I think it's fair to say that new features that are on by default
> > are in fact bloat in some sense.
> 
> You cannot do any metric based on defconfig, since per. definition defconfig is what
> suits Linus's current i386 PC best.
> If you really want to do a proper metric do something like the follwoing:
> 
> make allnoconfig
> Use some sed/awk magic to enable the options you are interested in
> - Networking
> - procfs?
> - ext2
> - One net driver
> - A bit more which make sense
> make oldconfig
> 
> This should result in a reliable config for code metrics.
> You just have to inspect that noone of your manually added options
> are no longer recognized (grep for warnings in output).
> 
> If you get this working it would be nice to see the evolution starting from 2.6.1 and
> onwards in line with John Cherrys compile stats.

I would be glad to add bloat stats to the existing compile statistics. 
However, as has been mentioned, the default config options (defconfig,
allyesconfig, and allmodconfig) change over time.  The value in the
bloat statistics would be up to the developer who could interpret these
stats relative to the current default configs.

> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

