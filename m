Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVBHLhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVBHLhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 06:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVBHLhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 06:37:10 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:15330 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261513AbVBHLhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 06:37:07 -0500
Date: Tue, 8 Feb 2005 11:31:32 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Robin Holt <holt@sgi.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: A scrub daemon (prezeroing)
Message-ID: <20050208113131.GA5143@linux-mips.org>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com> <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050127131228.GB31288@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127131228.GB31288@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 07:12:29AM -0600, Robin Holt wrote:

> > Some architectures tend to have spare DMA engines lying around. There's
> > no need to use the CPU for zeroing pages. How feasible would it be for
> > scrubd to use these?
> 
> An earlier proposal that Christoph pushed would have used the BTE on
> sn2 for this.  Are you thinking of using the BTE on sn0/sn1 mips?

On BCM1250 SOCs we've gone a step beyond that and use the Data Mover to
clear_page(), see arch/mips/mm/pg-sb1.c.  It's roughly comparable to the
SN0 BTE.  Broadcom has meassured a quite large performance win for such
a small code change.

  Ralf
