Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVKPFsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVKPFsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVKPFsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:48:11 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:13018 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S932588AbVKPFsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:48:10 -0500
Date: Wed, 16 Nov 2005 00:47:58 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Jon Masters <jcm@jonmasters.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>
Subject: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Message-ID: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Commit 88baf3e85af72f606363a85e9a60e9e61cc64a6c:

 "[PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk"

causes an annoying side-effect. Upon first write attempt to a floppy I get 
this:

$ dd if=bootdisk.img of=/dev/fd0 bs=1440k
dd: writing `/dev/fd0': Operation not permitted
1+0 records in
0+0 records out

Any successive attempts succeed without problem. Confirmed that backing 
out the patch fixes it.

-cp

-- 
Phishing, pharming; n.: Ways to obtain phood. -- The Devil's Infosec Dictionary

