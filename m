Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUEPRmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUEPRmg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUEPRmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:42:36 -0400
Received: from siolinb.obspm.fr ([145.238.2.18]:63130 "EHLO siolinb.obspm.fr")
	by vger.kernel.org with ESMTP id S264129AbUEPRme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:42:34 -0400
Date: Sun, 16 May 2004 19:42:33 +0200 (CEST)
From: Etienne Vogt <etienne.vogt@obspm.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: aic79xx trouble
In-Reply-To: <200405132136.32703.bernd.schubert@pci.uni-heidelberg.de>
Message-ID: <Pine.LNX.4.58.0405161930260.2851@siolinb.obspm.fr>
References: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de>
 <200405132136.32703.bernd.schubert@pci.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 May 2004, Bernd Schubert wrote:

> Oh, I forgot the system specifications:
>
> - dual opteron on tyan S2882 board
> - vanilla linux-2.4.26
>
> > we are just in the process of setting up a new server, which will serve the
> > data of an IDE/SCSI raid system (transtec 5008). Some partions of this raid
> > device are also mirrored via drbd to a failover system. During a full
> > resync of all (3) failover partitions *from* the failover server, the
> > main-server first logs many scsi errors and later the access to the
> > raid-partitions completely locks up.
> >
> > Below is some relevant dmesg output, I already enabled the verbose option
> > for the aic79xx driver. Should I also enable debugging, if so, which mode?

 The Adaptec Ultra320 cards (aic79xx) do not work reliably on Tyan Thunder
motherboards. Lots of SCSI errors and eventually complete system lockup.
I guess those motherboards have a crappy PCI bus with a lot of noise
that can't cope with the high transfer speed of these SCSI cards.
 I suggest you try an Ultra160 card. We have 3 Tyan Thunder based systems
here (those are dual Athlon MP2800) that work fine with Adaptec Ultra160
cards (aic7xxx) but give lots of errors with the Ultra320 cards.

-- 
		Etienne Vogt (Etienne.Vogt@obspm.fr)
		Unix System Manager
		Observatoire de Paris-Meudon, France
