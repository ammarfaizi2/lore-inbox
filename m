Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVLHPDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVLHPDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVLHPDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:03:54 -0500
Received: from pat.uio.no ([129.240.130.16]:3804 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932162AbVLHPDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:03:53 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       "'Andreas Dilger'" <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1134053446.17436.51.camel@imp.csi.cam.ac.uk>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
	 <1133963528.27373.4.camel@lade.trondhjem.org>
	 <1133967716.8910.5.camel@kleikamp.austin.ibm.com>
	 <1133969671.27373.47.camel@lade.trondhjem.org>
	 <1133973247.8907.33.camel@kleikamp.austin.ibm.com>
	 <02ab01c5fbeb$faf7d740$4168010a@bsd.tnes.nec.co.jp>
	 <1134052043.7998.26.camel@lade.trondhjem.org>
	 <1134053446.17436.51.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 10:03:14 -0500
Message-Id: <1134054194.7998.47.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.067, required 12,
	autolearn=disabled, AWL 1.75, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 14:50 +0000, Anton Altaparmakov wrote:

> And it breaks applications, too (e.g. du will then report all your files
> to be zero size)...

That's not a problem. We have our own ->getattr() method, so we can set
stat->blocks to the correct value. The only real side effect is
therefore that we waste space in the inode.

Cheers,
  Trond

