Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVBUThn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVBUThn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVBUThY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:37:24 -0500
Received: from main.gmane.org ([80.91.229.2]:1164 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262120AbVBUTeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 14:34:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
Subject: Re: [ANNOUNCE] yaird, a mkinitrd based on hotplug concepts
Date: Mon, 21 Feb 2005 19:13:55 +0000 (UTC)
Message-ID: <loom.20050221T200156-316@post.gmane.org>
References: <20050217210620.A20645@banaan.localdomain> <pan.2005.02.19.17.28.01.674334@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.126.2.237 (Mozilla)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus <aj <at> dungeon.inka.de> writes:
> it looks like yaird does use pivot_root.
> however pivot_root and initramfs cause a kernel crash
> (once you unmount /initrd in the real system).
> use run-init from klibc instead and you are fine.

You're right: pivot_root and initramfs don't mix, so yaird uses 
pivot_root only in the Debian template, which still has initrd.
The initramfs template manages to boot without run-init using a
hack that's too embarrasing to quote without rot13; klibc is needed
indeed.

Thanks,
Erik






