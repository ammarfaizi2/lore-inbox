Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751912AbWAEDvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbWAEDvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWAEDvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:51:23 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39633 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750994AbWAEDvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:51:22 -0500
Date: Thu, 5 Jan 2006 03:51:18 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 08/41] m68k: fix macro syntax to make current binutils happy
Message-ID: <20060105035118.GS27946@ftp.linux.org.uk>
References: <E1EtvYX-0003Lo-Gf@ZenIV.linux.org.uk> <200601050412.16136.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601050412.16136.zippel@linux-m68k.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 04:11:35AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Wednesday 04 January 2006 00:27, Al Viro wrote:
> 
> > recent as(1) doesn't think that . terminates a macro name, so
> > getuser.l is _not_ treated as invoking getuser with .l as the
> > first argument.
> 
> Al, please don't send the binutils patches yet, I simply need more time to 
> figure out how to deal with it and it's not a critical patch.
> Linus, please don't apply patch 8 and 9.

OK.  Nothing else depends on those; however, getuser.l stuff _is_ documented.

Frankly, my preference long-term would be to kill the .macro and just
use C preprocessor for expansion.  Do you have any objections against
such variant?
