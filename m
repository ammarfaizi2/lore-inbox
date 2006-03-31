Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWCaHsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWCaHsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWCaHsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:48:03 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48326
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751252AbWCaHsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:48:02 -0500
Date: Thu, 30 Mar 2006 23:48:23 -0800 (PST)
Message-Id: <20060330.234823.109651253.davem@davemloft.net>
To: adrian@smop.co.uk
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback (found)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060331072859.GA5389@smop.co.uk>
References: <20060330.152821.24959319.davem@davemloft.net>
	<20060331012235.GB45568@muc.de>
	<20060331072859.GA5389@smop.co.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bridgett <adrian@smop.co.uk>
Date: Fri, 31 Mar 2006 08:28:59 +0100

> On Fri, Mar 31, 2006 at 03:22:35 +0200 (+0200), Andi Kleen wrote:
> > On Thu, Mar 30, 2006 at 03:28:21PM -0800, David S. Miller wrote:
> > > From: Adrian Bridgett <adrian@smop.co.uk>
> > > Date: Fri, 31 Mar 2006 00:11:31 +0100
> > > 
> > > > Hmm - it looks like it was meant to be reverted in 2.6.16-rc1-mm4,5 FWIW.
> > > 
> > > So is the current version in Linus's tree causing this problem?
> 
> I'm taking 2.6.16(.0) adding -mm1.  When running dvbstream I get
> dentry_cache and sock_inode_cache leaking about 4MB/s.
> 
> I then revert this ENFILE/EMFILE patch and both leaks stop.

As I stated, there was a bug in the initial patch, which subsequent
patches fix.

Can you try Linus's current tree to see if the problem is there?
