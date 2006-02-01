Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWBASIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWBASIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422682AbWBASIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:08:40 -0500
Received: from fmr23.intel.com ([143.183.121.15]:2227 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932448AbWBASIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:08:39 -0500
Message-Id: <200602011807.k11I7ag15563@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Akinobu Mita'" <mita@miraclelinux.com>, "Grant Grundler" <iod00d@hp.com>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH 1/12] generic *_bit()
Date: Wed, 1 Feb 2006 10:07:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYnWb1G+/xcKV22QVyeWI4bq1TQrwAAFEkA
In-Reply-To: <20060201180237.GA18464@infradead.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote on Wednesday, February 01, 2006 10:03 AM
> > Akinobu Mita wrote on Wednesday, January 25, 2006 7:29 PM
> > > This patch introduces the C-language equivalents of the functions below:
> > > 
> > > - atomic operation:
> > > void set_bit(int nr, volatile unsigned long *addr);
> > > void clear_bit(int nr, volatile unsigned long *addr);
> > > void change_bit(int nr, volatile unsigned long *addr);
> > > int test_and_set_bit(int nr, volatile unsigned long *addr);
> > > int test_and_clear_bit(int nr, volatile unsigned long *addr);
> > > int test_and_change_bit(int nr, volatile unsigned long *addr);
> > 
> > I wonder why you did not make these functions take volatile
> > unsigned int * address argument?
> 
> Because they are defined to operate on arrays of unsigned long

I think these should be defined to operate on arrays of unsigned int.
Bit is a bit, no matter how many byte you load (8/16/32/64), you can
only operate on just one bit.

- Ken

