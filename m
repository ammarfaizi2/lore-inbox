Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbUCYDF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbUCYDF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:05:59 -0500
Received: from hera.kernel.org ([63.209.29.2]:27815 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263135AbUCYDF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:05:56 -0500
Date: Thu, 25 Mar 2004 01:06:34 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-pre6
Message-ID: <20040325040634.GA16616@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes the last -pre of 2.4.26 series.

It contains an ACPI update, SPARC/m68k/x86-64 (the latter adding 
basic support for Intel IA32e), amongst others.

Detailed changelog follows


Summary of changes from v2.4.26-pre5 to v2.4.26-pre6
============================================

<davem:nuts.davemloft.net>:
  o [SPARC64]: Update defconfig
  o [SPARC64]: Fix sys32_mount type arg handling

<len.brown:intel.com>:
  o [ACPI] check "maxcpus=N" early -- same as NR_CPUS check
  o [ACPI] clean up acpi_disabled use __initdata on IA64 was a bug since it is referenced by modules.
  o [ACPI] create disable_acpi()
  o [ACPI] fix interrupt behind yenta cardbus bridge (David Shaohua Li) http://bugzilla.kernel.org/show_bug.cgi?id=1564
  o [ACPI] delete POWER_OF_2 array (Pavel Machek)
  o [ACPI]   toshiba_acpi 0.18 from John Belmonte add missing copyin
  o [ACPI] ACPI SCI shall be level/low unless explicit over-ride http://bugzilla.kernel.org/show_bug.cgi?id=1622 add "acpi_sci=edge" and "acpi_sci=high" manual over-ride

<marcelo:logos.cnet>:
  o Avoid readahead from reading last page of file
  o Changed EXTRAVERSION to -pre6

<mlord:pobox.com>:
  o Fix bogus vmalloc() vm_area_free_pages call

Andi Kleen:
  o x86-64 update: simple support for IA32e/EM64T

Daniel Ritz:
  o yenta pcmcia driver: add some cardbus bridges to override lis

Geert Uytterhoeven:
  o Mac baboon warning
  o Amiga Oktagon URL
  o Mac missing include
  o M68k keyboard

Jeff Garzik:
  o [MAINTAINERS] remove defunct linux-via mailing list
  o [scsi] export scsi_finish_command
  o [pci] add a couple of constants

Trond Myklebust:
  o NFS: Make sure that fsync() flushes all pending file data to disk. The current call to nfs_wb_file() will fail to flush out mmapped() dirty pages.
  o NFS: make sure we revalidate attributes on completing a rename(): the server should normally update the ctime...

