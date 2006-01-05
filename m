Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752152AbWAELhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbWAELhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbWAELhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:37:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52450 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752152AbWAELhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:37:10 -0500
Date: Thu, 5 Jan 2006 11:37:08 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 08/41] m68k: fix macro syntax to make current binutils happy
Message-ID: <20060105113708.GT27946@ftp.linux.org.uk>
References: <E1EtvYX-0003Lo-Gf@ZenIV.linux.org.uk> <200601050412.16136.zippel@linux-m68k.org> <20060105035118.GS27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105035118.GS27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 03:51:18AM +0000, Al Viro wrote:
> On Thu, Jan 05, 2006 at 04:11:35AM +0100, Roman Zippel wrote:
> > Hi,
> > 
> > On Wednesday 04 January 2006 00:27, Al Viro wrote:
> > 
> > > recent as(1) doesn't think that . terminates a macro name, so
> > > getuser.l is _not_ treated as invoking getuser with .l as the
> > > first argument.
> > 
> > Al, please don't send the binutils patches yet, I simply need more time to 
> > figure out how to deal with it and it's not a critical patch.
> > Linus, please don't apply patch 8 and 9.
> 
> OK.  Nothing else depends on those; however, getuser.l stuff _is_ documented.
> 
> Frankly, my preference long-term would be to kill the .macro and just
> use C preprocessor for expansion.  Do you have any objections against
> such variant?

Scratch that; too much PITA to implement the horrors you've got there
(vararg recursive macros <shudder>).

Al, very tempted to do scripts/m4/ - would far more compact than e.g. kconfig,
if we don't bother with GNU extensions; classic m4 is essentially a weekend
project...
