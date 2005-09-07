Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVIGSRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVIGSRF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVIGSRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:17:04 -0400
Received: from serv01.siteground.net ([70.85.91.68]:8602 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932188AbVIGSRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:17:03 -0400
Date: Wed, 7 Sep 2005 11:16:54 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050907181654.GB3769@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain> <1126112950.8928.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126112950.8928.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 06:09:10PM +0100, Alan Cox wrote:
> On Maw, 2005-09-06 at 16:33 -0700, Ravikiran G Thirumalai wrote:
> > 2. Change the core ide code to use hwgroup->lock instead of ide_lock.
> > Deprecate ide_lock (patch 2)
> 
> hwgroups and IDE locking requirements are frequently completely
> unrelated. Its clear from the changes proposed you've not tested on real
> hardware for each case and you have not studied the documented errata

I tested it on a 2way box with a piix controller. It got through Bonnie++.  
I have access to piix controllers only, so that was the only controller 
I changed.  I did not read the errata though... :(

Do you think the approach is unsafe, even if the piix tune routine is
serialized with a per-driver lock?  Bartlomiej?

Thanks,
Kiran

