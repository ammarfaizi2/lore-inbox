Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVCGWKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVCGWKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVCGWGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:06:25 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:29448 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261815AbVCGVkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:40:02 -0500
Message-Id: <200503080010.j280ABbc005264@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Blaisorblade <blaisorblade@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK doesn't compile 
In-Reply-To: Your message of "Mon, 07 Mar 2005 20:44:48 +0100."
             <200503072044.49206.blaisorblade@yahoo.it> 
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <1108380903.22656.9.camel@imp.csi.cam.ac.uk> <200503051945.j25JjIB5003539@ccure.user-mode-linux.org>  <200503072044.49206.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 19:10:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it said:
> a) wrong because you say __GNUC_PATCHLEVEL__ > 4 rather than >= 

Correct, this is now fixed.

> b) wrong because for he the link failed on __bb_init_func at the
> beginning. So  in the case you need to export BOTH symbols. 

Incorrect, the link failure was caused by trying to export __bb_init_func,
which makes a reference to it, which was subsequently not being resolved.

You can't export a symbol which doesn't exist.

				Jeff

