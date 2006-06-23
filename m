Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWFWLdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWFWLdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933044AbWFWLdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:33:06 -0400
Received: from twin.jikos.cz ([213.151.79.26]:61164 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S933040AbWFWLdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:33:05 -0400
Date: Fri, 23 Jun 2006 13:31:38 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: modpost change proposed
Message-ID: <20060623113138.GA29844@kestrel.barix.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

If the modpost has error it dumps core:
modpost: vmlinux no symtab?
/bin/sh: line 1: 28307 Aborted                 (core dumped)
scripts/mod/modpost -o
/home/clock/edb9302/cirrus-arm-linux-1.0.7/linux-2.6.8.1/Module.symvers
vmlinux drivers/net/wireless/hermes.o drivers/net/wireless/orinoco.o
drivers/net/wireless/orinoco_cs.o drivers/usb/gadget/g_file_storage.o
make[1]: *** [__modpost] Error 134

I suggest the abort(); to be everywhere replaced with exit(1) for the
following reasons:
1) it's customary
2) core dumping looks scary
3) the core takes up space on disk

Regards,

CL<
