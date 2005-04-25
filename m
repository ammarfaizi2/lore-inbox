Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVDYQY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVDYQY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVDYQXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 12:23:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36766 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262669AbVDYQOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:14:24 -0400
Date: Mon, 25 Apr 2005 17:14:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
       dougg@torque.net, Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
Message-ID: <20050425161411.GA11938@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	andrew.patterson@hp.com, Eric.Moore@lsil.com, mike.miller@hp.com,
	dougg@torque.net, Madhuresh_Nagshain@adaptec.com
References: <425D392F.2080702@adaptec.com> <20050424111908.GA23010@infradead.org> <426D1572.70508@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426D1572.70508@adaptec.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 12:06:10PM -0400, Luben Tuikov wrote:
> On 04/24/05 07:19, Christoph Hellwig wrote:
> > 
> > This is contrary to any sysfs topology I know about, especially any
> > existing transport class (SPI, FC, iSCSI).
> 
> This RFC is about SAS.

But our SAS transport class should be consistant with the other transport
classes.

> >  We only ever care about what's seen from a HA,
> 
> Imagine you could connect to the same device via two
> different PCI controllers on the same host.

Which is exactly the case in the examples I've mentioned.

> 
> > e.g. if you have muliple SPI cards that are
> > on a single parallel bus you'll have the same bus represented twice,
> > similarly if you have two fibre channel HBAs connected to the same
> > SAN you'll have the SAN topology duplicated in both sub-topologies.
> 
> Hmm, this proposal is for SAS only, Christoph.
> 
> If you have multiple SAS host adapters connected to the same
> SAS domain, the _path_ they connect to a SAS device may be _different_.
> But what is the same is the SAS domain (topology) itself *regardless of
> how you connect to it.*
> 
> In order to eliminate duplication of sysfs entries (directories
> and files) to describe the same SAS device, we split up the
> representation into a "flat" directory with just a bunch
> of SAS devices, this is /sys/bus/sas/.  And the way you _connect_
> to those SAS devices is represented in sys/class/sas_ha/.

Please read the previous mail again, you're not getting it at all.

If you don't understand the problems it's not worth talking about more.
