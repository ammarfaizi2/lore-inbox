Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUG1X4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUG1X4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUG1X4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:56:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:37531 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266531AbUG1X4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:56:13 -0400
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com
In-Reply-To: <m1pt6f681y.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	 <200407280903.37860.jbarnes@engr.sgi.com>
	 <m1bri06mgw.fsf@ebiederm.dsl.xmission.com>
	 <200407281106.17626.jbarnes@engr.sgi.com>
	 <20040728124405.1a934bec.akpm@osdl.org>
	 <m1pt6f681y.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091055192.31923.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Jul 2004 23:53:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-07-29 at 00:11, Eric W. Biederman wrote:
> If we can ensure the addresses where the new kernel will run will never
> have DMA pointed at them I actually don't think so.  This is why last
> year I recommended building a kernel that runs at a non-default address
> and finding a way to simply preload it there.

We DMA into arbitary allocated pages anywhere in the memory space, so
you never know where is safe other than areas preallocated during the
old kernel run.

Since you can just clear the master bit on each PCI device it isnt a big
deal to protect against. (except a couple of devices that forget
to honour it)

