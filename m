Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVIUOnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVIUOnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVIUOnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:43:17 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:56917 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751008AbVIUOnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:43:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=J9O5Rbx22SpOYDCegREP7HqgBuTP6kkVpv0HjMySyTNaYpGU6Nwf8+IQhrJ5UOQoTV0ZNgWBYcI0+vBYWYljxbJUi6SLHwdrux+9SkM7dO89VQkENi0eNhO8mogSoozVPJ0Fe+S+HGVQLA5zr3LjDLLiNmi82Gnp71rsDFYT3JI=
Date: Wed, 21 Sep 2005 18:53:49 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc2-kj1
Message-ID: <20050921145349.GA1897@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.14-rc2-kj1 aka "Affine Albatross" is out. You can grab it from
http://coderock.org/kj/2.6.14-rc1-kj1/

Full shortlog is at
http://coderock.org/kj/2.6.14-rc2-kj1/shortlog

Merged
------
kernel_audit_c_fix_sparse_warnings___nocast_type.patch
i386_reboot_c_replace_custom_macro_with_isdigit.patch
remove_arch_arm26_boot_compressed_hw_bse_c.patch

New in this release
-------------------
Christoph Hellwig:
  specialix: check_region/request_region related cleanups

Christophe Lucas:
  arch/alpha/kernel/*: use KERN_*
  	two new files

Dropped
-------
arm_sa1111_c_use_sizeof_pointer.patch
	There was a discussion and much disagreement about sizeof(*p)
	vs sizeof(struct foo) on linux-kernel (grep for "Russell King
	sizeof").
	
	Net result #1: maintainer decides what to put into sizeof.
	Net result #2: kernel janitors won't convert code to either
		       form.

floppy_relocate_devfs_comment.patch
	akpm() returned -ETOOTRIVIAL.

gt96100_stop_using_pci_find_device.patch
	Should be converted to standart PCI API instead.

prism54_use_msleep.patch
	Old patch to use msleep() instead of schedule_timeout(). netdev
	tree switched to schedule_timeout_uninterruptible(). I'll wait
	for API dust to settle.

stir4200_use_set_current_state.patch
	Ditto.

