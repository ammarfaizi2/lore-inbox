Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVLUOXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVLUOXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 09:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVLUOXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 09:23:47 -0500
Received: from mx1.suse.de ([195.135.220.2]:32185 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932428AbVLUOXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 09:23:47 -0500
Date: Wed, 21 Dec 2005 15:23:41 +0100
From: Olaf Hering <olh@suse.de>
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: console on POWER4 not working with 2.6.15
Message-ID: <20051221142341.GA23639@suse.de>
References: <20051220204530.GA26351@suse.de> <20051220214525.GB7428@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051220214525.GB7428@pb15.lixom.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Dec 20, Olof Johansson wrote:

> On Tue, Dec 20, 2005 at 09:45:30PM +0100, Olaf Hering wrote:
> > The connection of ttyS0 to /dev/console doesnt seem to work anymore mit
> > 2.6.15-rc5+6 on a POWER4 p630 in fullsystempartition mode, no HMC
> > connected. It works with 2.6.14.4.
> > I tested 2.6.15-rc6 arch/powerpc/configs/ppc64_defconfig.
> 
> It seems to have been broken a while: According to test.kernel.org (last
> machine in the matrix is an SMP mode p650), it broke between 2.6.14-git2
> and 2.6.14-git3. Console output can be found in:

my bisect result doesnt make much sense. The bad one is
12a39407f021fd17d5f9d33d78bddb005bd106fb

good ones are 
.git/refs/bisect/good-0b360adbdb54d5b98b78d57ba0916bc4b8871968
.git/refs/bisect/good-1480d0a31db62b9803f829cc0e5cc71935ffe3cc
.git/refs/bisect/good-9f75e1eff3edb2bb07349b94c28f4f2a6c66ca43
.git/refs/bisect/good-ecc81e0f719f566b75b222b8aef64c8b809b2e29

If I only knew how to export the tree state at these points...

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
