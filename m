Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbTIDJvh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTIDJvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:51:37 -0400
Received: from verein.lst.de ([212.34.189.10]:58060 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264868AbTIDJvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:51:36 -0400
Date: Thu, 4 Sep 2003 11:51:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: "David S. Miller" <davem@redhat.com>, Paul Mackerras <paulus@samba.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904095128.GA16696@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"David S. Miller" <davem@redhat.com>,
	Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk> <16215.1054.262782.866063@nanango.paulus.ozlabs.org> <20030904023624.592f1601.davem@redhat.com> <20030904104801.A7387@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904104801.A7387@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:48:01AM +0100, Russell King wrote:
> 2. The resource tree won't know about the upper bits or whatever sitting
>    in flags, and as such identical addresses on two different buses will
>    clash.
> 
> Resource start,end needs to be some unique quantity no matter which (PCI)
> bus you are on.

Yupp.  This makes me question again how the phys_addr_t thing is
supposed to work at all given struct resource uses unsigned long
for start and len, so the whole generic resource infrastructure
doesn't know about the higher bits...

Could someone point me a to a driver actually making use of the
extented ioremap address on ppc 44x?

