Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUBVIuI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 03:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUBVIuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 03:50:08 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:13200 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261202AbUBVIuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 03:50:02 -0500
Date: Sun, 22 Feb 2004 10:50:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040222095021.GB2266@mars.ravnborg.org>
Mail-Followup-To: "James H. Cloos Jr." <cloos@jhcloos.com>,
	linux-kernel@vger.kernel.org
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3y8qwv78e.fsf@lugabout.jhcloos.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 09:26:41AM -0500, James H. Cloos Jr. wrote:
> I was looking at the arch-specific make options for various archs,
> and found this bit of fun:
> 
> :; make help ARCH=sh
> [elided]
> Architecture specific targets (sh):
>   zImage                  - Compressed kernel image (arch/sh/boot/zImage)
>   SCCS            - Build for arch/sh/configs/SCCS
>   defconfig-adx           - Build for adx
>   defconfig-cqreek        - Build for cqreek
>   defconfig-dreamcast     - Build for dreamcast
>   defconfig-hp680         - Build for hp680
>   defconfig-se7751        - Build for se7751
>   defconfig-snapgear      - Build for snapgear
>   defconfig-systemh       - Build for systemh
> [elided]
> 
> The defconfig options only show up after a bk get in arch/sh/configs/.
The sh people have decided to create the list based on the content of the directory.
Therefore you see the SCCS entry, and that's why you need to do a 'bk bet'.
In general you cannot expect the konfig and build system to work 100% if there is
random files missing in the tree. Those files bk can checkout automatically is
more by luck - and no effort has been put into making this a trustworthy way
to do it.

I expect sh to change their defconfig system to the same infrastructure as used
by ppc, arm and others.

> There are also several archs that do not have any arch-specific
> help.  ppc64 (unlike ppc) is one such example.
Patches are welcome.

	Sam
