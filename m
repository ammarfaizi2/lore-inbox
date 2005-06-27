Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVF0XpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVF0XpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVF0XpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:45:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262010AbVF0Xox convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:44:53 -0400
Date: Mon, 27 Jun 2005 16:45:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels (was: Re: 2.6.12-mm2)
Message-Id: <20050627164540.7ded07fc.akpm@osdl.org>
In-Reply-To: <20050627025059.GC10920@ime.usp.br>
References: <20050626040329.3849cf68.akpm@osdl.org>
	<42BE99C3.9080307@trex.wsi.edu.pl>
	<20050627025059.GC10920@ime.usp.br>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Added linux1394-devel)

Rogério Brito <rbrito@ime.usp.br> wrote:
>
> Hi, Andrew.
> 
> I am experiencing problems with -mm kernels and my firewire HD. I can use
> it without any problems with Linus's 2.6.12, but I had problems with both
> -mm1 and -mm2 (I just compiled -mm2 to see if the problem would go away,
> but it didn't).
> 
> I am using the same .config file for all compiles, except that I wanted to
> use the -mm tree for some things that I think would be orthogonal to the
> issue (like using FUSE, for example).
> 
> I can't provide more details now, but as soon as I go to work with the
> machine that presented the problem, I can give you all the details.
> 
> Essentially, what happens with -mm kernels that don't happen with Linus's
> kernel is that the sbp2 module gets loaded, but it seems that the subsystem
> never gets to actually see the partitions of the HD (I am using a HFS+
> formatted disk for transfers of data between Linux and MacOS X).
> 
> If others also have the problem, I would like to know about it.
> 
> The Firewire controller that I am using is a vanilla VIA card and the HD is
> a Seagate PATA HD in a Firewire enclosure (it's a ADS Tech DLX-185, if I am
> not mistaken).
> 
> As I said, I can provide further details if wanted/needed.
> 
> 

Could you please generate the dmesg output from 2.6.12 and 2.6.12-mm2 and,
if there are any relevant-looking differences, send them?

Also, try:

wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-collect-host-bridge-resources-02.patch

patch -R -p1 < gregkh-pci-pci-collect-host-bridge-resources-02.patch

Thanks.
