Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSJPUJA>; Wed, 16 Oct 2002 16:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbSJPUJA>; Wed, 16 Oct 2002 16:09:00 -0400
Received: from fmr05.intel.com ([134.134.136.6]:52204 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261353AbSJPUI7>; Wed, 16 Oct 2002 16:08:59 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB1EF28F2E@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>,
       linux ia64 kernel list <linux-ia64@linuxia64.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [Linux-ia64] [patch 2.5.39] allow kernel to be virtually mapp
	ed from any physi cal address
Date: Wed, 16 Oct 2002 10:56:17 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I wrote:
> This patch provides just the code needed to virtually map the
> kernel to a fixed virtual address from whatever physical address
> it happened to be loaded at (it is assumed that the bootloader
> handled the issue of finding a suitably aligned piece of memory).

Elilo already knows how to find memory, as long as you either use
the "relocatable" keyword in elilo.conf, or the "-r" command-line
option to let it know that it is OK to relocate.

Using this elilo option means that the changes I provided for
vmlinux.ld.S can be very slightly simplified, it isn't necessary
to define BASE_KVADDR as "KERNEL_START + KERNEL_TR_PAGE_SIZE", you
can just use:

#define BASE_KVADDR	KERNEL_START

-Tony
