Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVLENej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVLENej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVLENej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:34:39 -0500
Received: from pat.uio.no ([129.240.130.16]:23774 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932418AbVLENei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:34:38 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Takashi Sato <sho@bsd.tnes.nec.co.jp>,
       Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20051205081121.GU14509@schatzie.adilger.int>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
	 <1133447539.8557.14.camel@kleikamp.austin.ibm.com>
	 <041701c5f742$d6b0a450$4168010a@bsd.tnes.nec.co.jp>
	 <20051202185805.GS14509@schatzie.adilger.int>
	 <02cd01c5f809$95a94620$4168010a@bsd.tnes.nec.co.jp>
	 <20051205081121.GU14509@schatzie.adilger.int>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 08:34:17 -0500
Message-Id: <1133789657.8027.31.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.994, required 12,
	autolearn=disabled, AWL 1.82, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 01:11 -0700, Andreas Dilger wrote:
> I don't know the exact specs of NFS v2 and v3, but I doubt they can have
> single files larger than 2TB.

The NFSv3 protocol supports file lengths up to and including 2^64,
however on 32-bit Linux clients, we're limited by the page cache's
inability to actually address more than 16TB.

Cheers,
  Trond

