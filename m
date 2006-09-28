Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161377AbWI2S2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161377AbWI2S2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWI2S2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:28:45 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:4003 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1161372AbWI2S2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:28:41 -0400
Date: Thu, 28 Sep 2006 19:22:38 +0100
To: linux-kernel@vger.kernel.org
Subject: fs/bio.c - Hardcoded sector size ?
Message-ID: <20060928182238.GA4759@julia.computer-surgery.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: ADAD DF3A AE05 CA28 3BDB  D352 7E81 8852 817A FB7B
X-GPG-Key: 1024D/817AFB7B (wwwkeys.uk.pgp.net)
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

In bio_endio()  there is the follow line:- 

	bio->bi_sector += (bytes_done >> 9);

and there is a similiar line assuming a 512byte sector in 
__bio_add_page() .

Is this a bug as the the actual  block size  should be available
from bio->bi_bdev->bd_block_size surely - or is some clever code
where all block devices have to translate back to 512 byte sectors
for bio s.

TTFN
-- 
Roger.                          Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
Work|Independent Sys Consultant | http://www.computer-surgery.co.uk/
So what are the eigenvalues and eigenvectors of 'The Matrix'? --anon
