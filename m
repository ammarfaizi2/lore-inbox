Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030602AbVLWS65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030602AbVLWS65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 13:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbVLWS65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 13:58:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64741 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030602AbVLWS64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 13:58:56 -0500
Date: Fri, 23 Dec 2005 13:58:48 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: con_set_trans_new breakage in 2.6.15rc6-git3
Message-ID: <20051223185848.GA5398@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an odd one, as this only just started happening,
but there's no obvious changes in this area.

EIP: 0060:[<c020b71b>]
EIP is at con_set_trans_new+0x2b/0x48
eax: 00000080 ebx: 00000000 ecx: bfcd4060 edx: fffff000
esi: bfcd4060 edi: c0408860 ebp: 00000001 esp: dfa6aeec
ds: 007b cs: 007b ss: 0068

Call Trace:
 vt_ioctl
 unmap_page_range
 selinux_file_ioctl
 vt_ioctl
 tty_ioctl
 tty_ioctl
 do_ioctl
 vfs_ioctl
 sys_ioctl
 syscall_call

(hand transcribed from a user report at http://adslpipe.co.uk/pxeboot.jpg)

Who maintains the tty layer these days ?

		Dave

