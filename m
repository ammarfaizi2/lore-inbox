Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTBXLXk>; Mon, 24 Feb 2003 06:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTBXLXk>; Mon, 24 Feb 2003 06:23:40 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:37641 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266994AbTBXLXj>; Mon, 24 Feb 2003 06:23:39 -0500
Date: Mon, 24 Feb 2003 11:33:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [ANN] NTFS 2.1.1a for kernel 2.4.20 released
Message-ID: <20030224113350.A3452@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net
References: <Pine.SOL.3.96.1030224111049.22477D-100000@draco.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.3.96.1030224111049.22477D-100000@draco.cus.cam.ac.uk>; from aia21@cantab.net on Mon, Feb 24, 2003 at 11:12:39AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 11:12:39AM +0000, Anton Altaparmakov wrote:
> NTFS 2.1.1a is now released for kernel 2.4.20. This fixes both the
> reported hangs and improves the handling of compressed files so that the
> warning message people keep reporting is now gone. (Note the hangs were
> specific to the 2.4.x kernel ntfs versions. 2.5.x kernel ntfs versions
> are not affected.)

This:

@@ -8,6 +8,7 @@ enum km_type {
        KM_USER0,
	KM_USER1,
	KM_BH_IRQ,
+       KM_BIO_IRQ,
	KM_TYPE_NR
};

is bogus.  You should be using KM_BH_IRQ.

And btw, 2.4.21-pre now has ->alloc_inode and ->destroy_inode, use them :)
