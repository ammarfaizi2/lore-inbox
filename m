Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUCNAPX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUCNAPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:15:22 -0500
Received: from waste.org ([209.173.204.2]:64450 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263226AbUCNAPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:15:16 -0500
Date: Sat, 13 Mar 2004 18:15:10 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040314001510.GR20174@waste.org>
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org> <20040313221741.GA1998@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313221741.GA1998@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 11:17:41PM +0100, Sam Ravnborg wrote:
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

And make oldconfig will go and turn on all the new stuff which is off
in defconfig and on in Kconfig.

But starting with a minimal config is not all that useful because it
doesn't show bloat creep in stuff people commonly use.

The point is not to distill everything down to one number, the point
is to get enough into the report that we can notice growth in all the
important areas. Obviously as things get renamed, moved around, etc.,
some closer inspection will be required to figure out what the impact
is. Changes in config workings are in the same bucket.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
