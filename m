Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUFXWo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUFXWo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUFXWoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:44:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:44948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265760AbUFXWdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 18:33:45 -0400
Date: Thu, 24 Jun 2004 15:36:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@holomorphy.com, nickpiggin@yahoo.com.au, tiwai@suse.de, ak@suse.de,
       ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-Id: <20040624153612.038ebd39.akpm@osdl.org>
In-Reply-To: <20040624222150.GZ30687@dualathlon.random>
References: <s5hhdt1i4yc.wl@alsa2.suse.de>
	<20040624112900.GE16727@wotan.suse.de>
	<s5h4qp1hvk0.wl@alsa2.suse.de>
	<20040624164258.1a1beea3.ak@suse.de>
	<s5hy8mdgfzj.wl@alsa2.suse.de>
	<20040624152946.GK30687@dualathlon.random>
	<40DAF7DF.9020501@yahoo.com.au>
	<20040624165200.GM30687@dualathlon.random>
	<20040624165629.GG21066@holomorphy.com>
	<20040624145441.181425c8.akpm@osdl.org>
	<20040624222150.GZ30687@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Thu, Jun 24, 2004 at 02:54:41PM -0700, Andrew Morton wrote:
> > First thing to do is to identify some workload which needs the patch. 
> 
> that's quite trivial, boot a 2G box, malloc(1G), bzero(1GB), swapoff -a,
> then the machine will lockup.

Are those numbers correct?  We won't touch swap at all with that test?
