Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVE0RWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVE0RWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVE0RWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:22:44 -0400
Received: from animx.eu.org ([216.98.75.249]:18601 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262517AbVE0RWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:22:41 -0400
Date: Fri, 27 May 2005 13:19:41 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc[2-5] hangs when umounting initramfs
Message-ID: <20050527171941.GA12964@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I originally started with an initrd and later changed to initramfs.

I mount tmpfs to /newroot, populate /newroot, pivot_root to /newroot (via
pivot_root . initrd), kill off everything running on the old root and umount
/initrd.

When I boot and I load a ramdisk image via initrd, umount works and
everything continues.  When I send a compressed cpio via initrd and umount,
the system hangs.  No messages, no keyboard response, nothing.  sysrq works,
but since the kernel I built was designed with size in mind, the information
isn't very useful.

When I do sysrq-t, it shows mount as running.  Not actually sure if it is.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
