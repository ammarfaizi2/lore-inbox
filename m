Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbULZSlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbULZSlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbULZSlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:41:12 -0500
Received: from fsmlabs.com ([168.103.115.128]:8127 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261728AbULZSlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:41:07 -0500
Date: Sun, 26 Dec 2004 11:41:11 -0700 (MST)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Larry McVoy <lm@bitmover.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK] disconnected operation
In-Reply-To: <20041226171900.GA27706@work.bitmover.com>
Message-ID: <Pine.LNX.4.61.0412261124220.17702@montezuma.fsmlabs.com>
References: <1104077531.5268.32.camel@mulgrave> <20041226162727.GA27116@work.bitmover.com>
 <1104079394.5268.34.camel@mulgrave> <20041226171900.GA27706@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004, Larry McVoy wrote:

> On Sun, Dec 26, 2004 at 10:43:13AM -0600, James Bottomley wrote:
> > On Sun, 2004-12-26 at 08:27 -0800, Larry McVoy wrote:
> > > I suspect that your hostname changes when you disconnect.  Leases are 
> > > issued on a per host basis.  If you make your hostname constant when
> > > you unplug it should work.  If it doesn't, let us know.
> > 
> > Well, that's a new one, but no, I have a fixed hostname which dhcp is
> > forbidden from changing.
> 
> Let's do a little poll here to find out if it is specific to you or if
> this is a problem that everyone is having.  Could we get people who
> use BK disconnected to stand up and be counted?  Does this work for 
> anyone?

I use it whilst on travel too, however i do not have a similar problem as 
described by James but i've noticed that simple operations like `bk vi 
filename` take extremely long;

zwane@r3000 ~ {0:0} bk version
BitKeeper version is bk-3.2.3 20040818155841 for x86-glibc23-linux
Built by: lm@redhat9.bitmover.com in /build/3.2.x-lm/src
Built on: Wed Aug 18 11:18:31 PDT 2004
Running on: Linux 2.6.10-R3000

zwane@r3000 linux {0:0} time bk cat user.h
#include <asm/user.h>
0.032u 0.004s 0:40.15 0.0%      0+0k 0+0io 1pf+0w

zwane@r3000 linux-2.6-bk {1:0} time bk get Makefile
Makefile 1.551: 1318 lines
0.074u 0.014s 0:32.79 0.2%      0+0k 0+0io 0pf+0w

My hostname is fixed, i do not have a default gateway set and none of the 
nameservers listed in /etc/resolv.conf are reachable. This could very well 
be a local configuration problem but you did ask for people who use BK 
disconnected to stand up =)

Thanks,
	Zwane
