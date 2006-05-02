Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWEBOod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWEBOod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWEBOod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:44:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55501 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964850AbWEBOoc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:44:32 -0400
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland Dreier <rdreier@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <adaaca0mrn1.fsf@cisco.com>
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
	 <ada3bftvatf.fsf@cisco.com>
	 <1146509646.20760.63.camel@laptopd505.fenrus.org>
	 <aday7xltvtb.fsf@cisco.com> <20060502133507.GA26704@infradead.org>
	 <adaaca0mrn1.fsf@cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 15:55:04 +0100
Message-Id: <1146581705.3519.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-02 at 07:24 -0700, Roland Dreier wrote:
> But see my earlier mail to Arjan about RDMA -- what address can a
> protocol (eg SRP initiator) put in a message that the other side will
> use to initiate a remote DMA operation?  It seems to me it has to be a
> bus address, and that means that the protocol has to do the DMA mapping.

For most drivers properly, but you are making assumptions again. Why
can't a driver which is doing its own mapping not also do its own rdma
cookie handling ? You opt out of mapping being done for you, then you
get opted out of defaults for other stuff too.

Alan

