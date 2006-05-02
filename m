Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWEBOYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWEBOYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWEBOYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:24:22 -0400
Received: from test-iport-3.cisco.com ([171.71.176.78]:2890 "EHLO
	test-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964837AbWEBOYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:24:21 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
X-Message-Flag: Warning: May contain useful information
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
	<ada3bftvatf.fsf@cisco.com>
	<1146509646.20760.63.camel@laptopd505.fenrus.org>
	<aday7xltvtb.fsf@cisco.com> <20060502133507.GA26704@infradead.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 02 May 2006 07:24:18 -0700
In-Reply-To: <20060502133507.GA26704@infradead.org> (Christoph Hellwig's message of "Tue, 2 May 2006 14:35:07 +0100")
Message-ID: <adaaca0mrn1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 May 2006 14:24:19.0468 (UTC) FILETIME=[198BD4C0:01C66DF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christoph> Or stop doing the dma mapping in the IB upper level
    Christoph> drivers.  I told you that we'll get broken hardware
    Christoph> that doesn't want dma mapping in the upper level
    Christoph> driver, and pathscale created exactly that :)

But see my earlier mail to Arjan about RDMA -- what address can a
protocol (eg SRP initiator) put in a message that the other side will
use to initiate a remote DMA operation?  It seems to me it has to be a
bus address, and that means that the protocol has to do the DMA mapping.

 - R.
