Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVCEVOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVCEVOH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVCEVOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:14:06 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:29971 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261196AbVCEVNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:13:43 -0500
Date: Sat, 5 Mar 2005 22:08:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: 7eggert@nurfuerspam.de
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: diff command line?
Message-ID: <20050305210850.GI30106@alpha.home.local>
References: <fa.jshi2h6.1g20sjc@ifi.uio.no> <fa.h6jj2d8.143utbu@ifi.uio.no> <E1D7gBd-0000q3-3G@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D7gBd-0000q3-3G@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 09:47:44PM +0100, Bodo Eggert wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
> 
> >> What are the options normally used to generate a diff for public
> >> consumption on this list?
> > 
> > diff -urpN orig new
> > 
> > where "orig" and "new" both contain the top level "linux" directory,
> > so the resulting patch can be applied with patch -p1.
> 
> This seems to be a common mistake.

I often use a simple trick to make my single file patches compatible
with both -p0 and -p1 :

diff -pruN ./dir/file.orig ./dir/file.new

The './' can either get stripped by -p1 or left as is, thus the patch
works for different scripts or people. The main disadvantage is that
there's no base version indication in the patch with this method.

Regards,
Willy

