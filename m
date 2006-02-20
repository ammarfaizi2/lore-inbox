Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWBTX0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWBTX0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWBTX0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:26:42 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:42989 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161067AbWBTX0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:26:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HQbwXllN+CELyegcsVm34mnLmb6jn6G1bJIk2KMWXFQx6+25BpOai9WCcXYGC+IJ+PaMWgSTOR3+6ia961nKTb1Wk+ulq8mHcq3KDDShNsejnO353kUDPbXgPZiRJIsdmnfdaCVI/3drjKaqpdQ+9ae5h/M2gWlZ7ICYM0otXKA=
Message-ID: <43FA5022.6070404@gmail.com>
Date: Tue, 21 Feb 2006 07:26:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>, bjk@luxsci.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Bugzilla: PCI resource address mismatch
References: <43F91283.4050307@gmail.com> <20060220142600.A25613@jurassic.park.msu.ru>
In-Reply-To: <20060220142600.A25613@jurassic.park.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Mon, Feb 20, 2006 at 08:51:15AM +0800, Antonino A. Daplas wrote:
> Starting from 2.6.13, kernel tries to resolve that sort of conflicts,
> so that prefetch window of the bridge and the framebuffer memory behind
> it get moved to 0x10000000.
> Unfortunately, video BIOS still expects the framebuffer to be at 0xff000000,
> that's why vesafb doesn't work.
> 
> Booting with "mem=64M" (or what amount of RAM he has) should fix that,
> as it causes the kernel to ignore e820 entries above 64M.
> 

Ben reported that the mem= option worked for him.  I presume that this
is the best solution for this problem?

Tony
