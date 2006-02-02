Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWBCEzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWBCEzl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 23:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWBCEzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 23:55:41 -0500
Received: from ozlabs.org ([203.10.76.45]:50079 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750967AbWBCEzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 23:55:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17378.35622.918387.596756@cargo.ozlabs.ibm.com>
Date: Fri, 3 Feb 2006 09:43:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       "Grant Grundler" <iod00d@hp.com>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH 1/12] generic *_bit()
In-Reply-To: <200602011807.k11I7ag15563@unix-os.sc.intel.com>
References: <20060201180237.GA18464@infradead.org>
	<200602011807.k11I7ag15563@unix-os.sc.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W writes:

> Christoph Hellwig wrote on Wednesday, February 01, 2006 10:03 AM
> > Because they are defined to operate on arrays of unsigned long
> 
> I think these should be defined to operate on arrays of unsigned int.
> Bit is a bit, no matter how many byte you load (8/16/32/64), you can
> only operate on just one bit.

Christoph is right.  Changing to unsigned int would change the layout
on big-endian 64-bit platforms.

Paul.
