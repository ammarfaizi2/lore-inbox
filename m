Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTJCMjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 08:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTJCMjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 08:39:53 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:19841 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263731AbTJCMjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 08:39:52 -0400
Date: Fri, 3 Oct 2003 13:40:22 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310031240.h93CeM7P000941@81-2-122-30.bradfords.org.uk>
To: Erik Bourget <erik@midmaine.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87lls2tspv.fsf@loki.odinnet>
References: <87brsybm41.fsf@loki.odinnet>
 <200310031159.h93BxfYm000758@81-2-122-30.bradfords.org.uk>
 <87lls2tspv.fsf@loki.odinnet>
Subject: Re: CMD680, kernel 2.4.21, and heartache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Oct 1 07:47:47 mailstore2-1 kernel: hda: dma_intr: status=0x51 { DriveReady
> >> SeekComplete Error } Oct 1 07:47:47 mailstore2-1 kernel: hda: dma_intr:
> >> error=0x40 { UncorrectableError }, LBAsect=37694874, high=2, low=4140442,
> >> sector=35220864
> >
> > That is definitely an error from the drive.  If you're absolutely sure
> > it's not a faulty batch of drives or a cooling issue, maybe you have
> > power supply problems?  Does SMART give you any useful information?
> 
> Not power supply problems; two of the machines that have this problem are
> located in different facilities even.  What's SMART?

Self Monitoring Analysis and Reporting Technology, it allows drives to report reliability statistics.

Smartmontools includes a utility, 'smartctl', you may already have it installed.  If so:

smartctl -e /dev/hda <- Enable S.M.A.R.T.
smartctl -a /dev/hda <- Dump all data

might provide useful data.

John.
