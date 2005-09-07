Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVIGRu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVIGRu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVIGRu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:50:26 -0400
Received: from serv01.siteground.net ([70.85.91.68]:15562 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751259AbVIGRuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:50:25 -0400
Date: Wed, 7 Sep 2005 10:50:19 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 4/4] ide: Break ide_lock -- remove ide_lock  from piix driver
Message-ID: <20050907175019.GA3769@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain> <20050906234429.GE3642@localhost.localdomain> <1126112783.8928.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126112783.8928.14.camel@localhost.localdomain>
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

On Wed, Sep 07, 2005 at 06:06:23PM +0100, Alan Cox wrote:
> On Maw, 2005-09-06 at 16:44 -0700, Ravikiran G Thirumalai wrote:
> > Patch to convert piix driver to use per-driver/hwgroup lock and kill
> > ide_lock.  In the case of piix, hwgroup->lock should be sufficient.
> 
> PIIX requires that both channels are quiescent when retuning in some
> cases. It wasn't totally safe before, its now totally broken. Start by

Then the change to piix controller in my patchset is bad, How about changing
the ide_lock to per-driver lock in this case?  Locking for rest of the
controllers in the system is left equivalent to what ide_lock did earlier..


> fixing the IDE layer locking properly (or forward porting my patches and
> then fixing them for all the refcounting changes and other stuff done
> since).

Can you please point me to the patchset...

Thanks,
Kiran
