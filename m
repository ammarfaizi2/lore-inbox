Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVK2DbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVK2DbF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 22:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVK2DbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 22:31:05 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:58498 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S932352AbVK2DbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 22:31:04 -0500
Date: Tue, 29 Nov 2005 05:31:02 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: x86-64 2.6.15-rc2-git5 fails to boot with 4GB memory
Message-ID: <20051129033102.GA5706@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2 GB in place, the kernel boots just fine, but with
4 GB, it reports:

 kernel direct mapping tables upto ffff 8101 5000 000 @ 8000-f000
 PANIC: early exception rip  ffff ffff 8016 f002 error 0 cr2 4230
 PANIC: early exception rip  ffff ffff 8011 d1fe error 0 cr2 ffff ffff f5ff d023

and some other lines, which I didn't jot down on paper...
These were copied from some Fedora Core development kernel version
after 2.6.15-rc1 (last working one) in a box with 4 GB memory.

Those hex values didn't have intermediate spaces in them, though.
That was me trying to understand 64 bit values.

Last working kernel with all 4 GB memory in the box was  2.6.15-rc1
Since then the kernels have failed to boot at all, unless machine
PHYSICAL memory is stripped down to 2 GB.  Command-line options
(e.g. "mem=2G") don't help at all.

  /Matti Aarnio
