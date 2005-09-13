Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVIMUgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVIMUgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVIMUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:36:15 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:64942 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932279AbVIMUgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:36:14 -0400
Date: Tue, 13 Sep 2005 14:36:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Message-ID: <20050913203611.GH32395@parisc-linux.org>
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com> <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com> <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4327354E.7090409@adaptec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 04:23:42PM -0400, Luben Tuikov wrote:
> A SCSI LUN is not "u64 lun", it has never been and it will
> never be.
> 
> A SCSI LUN is "u8 LUN[8]" -- it is this from the Application
> Layer down to the _transport layer_ (if you cared to look at
> _any_ LL transport).

Could you explain the difference please?  Why is it preferable to keep
the LUN as an array of bytes instead of a single large integer?

> (It is also capitalized since it is an abbreviation.)

Well, we have two conflicting standards to follow here.  That of English
which insists that abbreviations be capitalised, and that of the kernel
which requires that all-caps identifiers be macros rather than structure
members.  We have to violate one.
