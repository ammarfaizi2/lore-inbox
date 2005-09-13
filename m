Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVIMPkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVIMPkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVIMPkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:40:21 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:9355 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964805AbVIMPkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:40:20 -0400
Date: Tue, 13 Sep 2005 09:40:14 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
Message-ID: <20050913154014.GE32395@parisc-linux.org>
References: <1126308949.4799.54.camel@mulgrave> <20050910041218.29183.qmail@web51612.mail.yahoo.com> <20050911093847.GA5429@infradead.org> <4325FA6F.3060102@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4325FA6F.3060102@adaptec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 06:00:15PM -0400, Luben Tuikov wrote:
> "transport attribute class" is just an _attribute_ class, Christoph.
> "transport layer" is a lot more involved.  I sincerely hope
> you can see this.  E.g. domain discovery belongs in the transport
> layer.  In SPI, LLDDs did it; in MPT the firmware does it.

LLDDs having their own domain discovery code is definitely a misfeature.
As you know, stuff is being rearranged to move more of the SPI-specific
code from both SCSI core and LLDDs into the SPI transport.  I suspect
domain discovery will always be triggered by the LLDD for SPI, but at
least a driver doesn't have to have its own code to do that any more.
