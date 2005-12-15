Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVLOWR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVLOWR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVLOWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:17:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29395 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751122AbVLOWRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:17:55 -0500
Subject: Re: Problems in the SiS IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20051214211216.GA6045@corona.suse.de>
References: <1134587705.25663.67.camel@localhost.localdomain>
	 <20051214211216.GA6045@corona.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Dec 2005 22:18:08 +0000
Message-Id: <1134685088.20495.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 22:12 +0100, Vojtech Pavlik wrote:
> > And timing can be zero....
> > 
> > Would be useful to know if this is a bug, and also what the correct
> > behaviour is at this point as I don't have all the SiS data sheets.
> 
> This is a bug - test1 should be initialized to 0.

Thanks. Will fix that in the pata_ version. The MWDMA support for some
chips also appears to be missing (it doesn't load timing values at all
and it doesn't do PIO/MWDMA setup timing checks).


Alan
