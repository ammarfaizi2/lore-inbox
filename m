Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRLSR5m>; Wed, 19 Dec 2001 12:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280686AbRLSR5Y>; Wed, 19 Dec 2001 12:57:24 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:29457 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S280638AbRLSR5M>; Wed, 19 Dec 2001 12:57:12 -0500
Date: Wed, 19 Dec 2001 18:57:09 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.17-rc2: highmem breaks loop, affs
Message-ID: <20011219185708.A31166@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Marcelo Tosatti wrote:

> So here it goes 2.4.17-rc2... as expected, bugfixes only.

A Highmem (4G) enabled kernel breaks loop and affs, without Highmem, it
is ok (SMP enabled kernel, 1 GB RAM):

depmod: *** Unresolved symbols in /lib/modules/2.4.17-rc2/kernel/drivers/block/loop.o
depmod: 	kunmap_high
depmod: 	create_bounce
depmod: 	highmem_start_page
depmod: 	kmap_high
depmod: *** Unresolved symbols in /lib/modules/2.4.17-rc2/kernel/fs/affs/affs.o
depmod: 	kunmap_high
depmod: 	highmem_start_page
depmod: 	kmap_high

I can provide a .config if needed.
