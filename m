Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965518AbWJaFKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965518AbWJaFKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 00:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965523AbWJaFKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 00:10:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965518AbWJaFKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 00:10:53 -0500
Date: Mon, 30 Oct 2006 21:10:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrew.j.wade@gmail.com
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Message-Id: <20061030211046.1c3d62b9.akpm@osdl.org>
In-Reply-To: <200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<200610302203.37570.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20061030191340.1c7f8620.akpm@osdl.org>
	<200610302258.31613.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 22:58:11 -0500
Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> > 
> > hm.  Please send the .config
> > 
> Sure.
> 
> I've just found out that unsetting CONFIG_SYSFS_DEPRECATED makes the
> crash go away. I can hack around the resulting udev incompatibility.
> 
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.19-rc3-mm1
> # Mon Oct 30 19:31:03 2006

Well I tried to reproduce this, but I got such a psychedelic cornucopia of
oopses at various bisection points amongst those sysfs patches that I think
I'll just give up.

Greg, Kay: it's quite ugly.  I'll drop all those patches for now, and I
suggest you do so too.  Have a play with the .config which Andrew sent..

