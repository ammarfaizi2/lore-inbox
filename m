Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUFPVl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUFPVl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266321AbUFPVlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:41:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27322 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266319AbUFPVlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:41:08 -0400
Date: Wed, 16 Jun 2004 17:40:48 -0400
From: Alan Cox <alan@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.orgy
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040616214048.GA27169@devserv.devel.redhat.com>
References: <20040616210455.GA13385@devserv.devel.redhat.com> <20040616213343.GA20488@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616213343.GA20488@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks mostly good except for the GART iommu ifdef.  That code is bogus for
> almost everything but a plain PC and should just be killed.

There are lots of problems with the PC centric view of the world some
aacraid hardware has.  At the moment I'm still working on trying to understand
the rules and I'll need to talk to Mark some more. I've also got a third
party trace suggesting a request for low DMA memory came in through the
gart which is above the address in the mask to look at.

Its something I hope to get rid of eventually. In the meantime the GART
define is needed to make it work on AMD64.

> Does this apply ontop of Marc's ioctl patch?

Its against 2.6.7

