Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266551AbUFQPRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266551AbUFQPRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUFQPRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:17:08 -0400
Received: from ozlabs.org ([203.10.76.45]:26846 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266545AbUFQPQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:16:57 -0400
Date: Fri, 18 Jun 2004 01:11:53 +1000
From: Anton Blanchard <anton@samba.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040617151153.GA30514@krispykreme>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2402C@otce2k03.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2402C@otce2k03.adaptec.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This would not be such an issue if Linux provided large SG elements
> rather than the fubar descending page order ones they issue today. If
> this could be fixed, I'd not even be interested in the optimization of
> the SG.

Please divert some of your anger towards your manufacturer of dodgy
hardware. Any sane hardware with an IOMMU handles this just fine.
eg on ppc64 running a disk test:

sg size    in        out
1           3      47569
2           0       2591
3           0       1123
4           0        447
5           0        429
...
62       5095          0
64      47061          0

The IOMMU is taking 62-64 entry SG lists and producing 1-5 entry lists.

Anton
