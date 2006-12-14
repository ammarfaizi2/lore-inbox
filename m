Return-Path: <linux-kernel-owner+w=401wt.eu-S932138AbWLNJZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWLNJZN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWLNJZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:25:13 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:15889 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbWLNJZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:25:11 -0500
Date: Thu, 14 Dec 2006 11:23:11 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Erik Andersen <andersen@codepoet.org>
Cc: Karsten Weiss <K.Weiss@science-computing.de>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061214092311.GC6674@rhun.haifa.ibm.com>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213202925.GA3909@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213202925.GA3909@codepoet.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 01:29:25PM -0700, Erik Andersen wrote:
> On Mon Dec 11, 2006 at 10:24:02AM +0100, Karsten Weiss wrote:
> > We could not reproduce the data corruption anymore if we boot
> > the machines with the kernel parameter "iommu=soft" i.e. if we
> > use software bounce buffering instead of the hw-iommu.
> 
> I just realized that booting with "iommu=soft" makes my pcHDTV
> HD5500 DVB cards not work.  Time to go back to disabling the
> memhole and losing 1 GB.  :-(

That points to a bug in the driver (likely) or swiotlb (unlikely), as
the IOMMU in use should be transparent to the driver. Which driver is
it?

Cheers,
Muli
