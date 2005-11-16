Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbVKPKuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVKPKuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVKPKuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:50:50 -0500
Received: from aun.it.uu.se ([130.238.12.36]:21681 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1030272AbVKPKut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:50:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17275.3826.215279.144207@alkaid.it.uu.se>
Date: Wed, 16 Nov 2005 11:50:26 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Cal Peake <cp@absolutedigital.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jon Masters <jcm@jonmasters.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
In-Reply-To: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake writes:
 > Hi,
 > 
 > Commit 88baf3e85af72f606363a85e9a60e9e61cc64a6c:
 > 
 >  "[PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk"
 > 
 > causes an annoying side-effect. Upon first write attempt to a floppy I get 
 > this:
 > 
 > $ dd if=bootdisk.img of=/dev/fd0 bs=1440k
 > dd: writing `/dev/fd0': Operation not permitted
 > 1+0 records in
 > 0+0 records out
 > 
 > Any successive attempts succeed without problem. Confirmed that backing 
 > out the patch fixes it.

I can confirm that I got the exact same mis-behaviour in -rc1.
