Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269133AbRHBUcC>; Thu, 2 Aug 2001 16:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269118AbRHBUbx>; Thu, 2 Aug 2001 16:31:53 -0400
Received: from pc1-cwbl2-0-cust80.cdf.cable.ntl.com ([62.252.63.80]:65518 "EHLO
	bagpuss.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269133AbRHBUbk>; Thu, 2 Aug 2001 16:31:40 -0400
From: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
Message-Id: <200107292034.f6TKYCf01444@bagpuss.swansea.linux.org.uk>
Subject: Re: [RFT] Support for ~2144 SCSI discs
To: mike.anderson@us.ibm.com (Mike Anderson)
Date: Sun, 29 Jul 2001 16:34:11 -0400 (EDT)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch),
        jeremy@classic.engr.sgi.com (Jeremy Higdon),
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20010731125926.B10914@us.ibm.com> from "Mike Anderson" at Jul 31, 2001 12:59:26 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In previous experiments trying to connect up to 512 devices we switched to
> vmalloc because the static nature of sd.c's allocation exceeds 128k which
> I assumed was the max for kmalloc YMMV.

vmalloc is fine, but for large sets of disks sd should be disk object
pointers instead, and a 32bit dev_t migration will be needed anyway
