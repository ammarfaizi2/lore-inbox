Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274204AbRISWF3>; Wed, 19 Sep 2001 18:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274203AbRISWFU>; Wed, 19 Sep 2001 18:05:20 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:64492 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274207AbRISWE6>; Wed, 19 Sep 2001 18:04:58 -0400
Importance: Normal
Subject: Regarding Jens' Zero-Bounce Highmem I/O Patch
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF2D7B8881.082D3FA6-ON85256ACC.0075C7C8@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Wed, 19 Sep 2001 17:04:59 -0500
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/19/2001 06:05:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use Jens' zero-bounce highmem I/O patch against 2.4.6,
a small modification for the patch is needed. Simply replace
GFP_BUFFER by GFP_NOIO in block-highmem-all-5.gz, which can be obtained
at http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.6-pre1/.

However, there is another problem. For both 2.4.5 and 2.4.6 with
Jens' patches, if the kernels are built with 4GB highmem, they
boot without problems. But if the kernels are built with 64GB
highmem, the kernels hang right after uncompressing Linux. Has
anyone seen this problem?

Thanks,
Peter

Wai Yee Peter Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com
Office: (512) 838-9272, T/L 678-9272; Fax: (512) 838-4663

