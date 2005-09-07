Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVIGQob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVIGQob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVIGQob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:44:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:55952 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751252AbVIGQoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:44:30 -0400
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
In-Reply-To: <20050906233322.GA3642@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Sep 2005 18:09:10 +0100
Message-Id: <1126112950.8928.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-06 at 16:33 -0700, Ravikiran G Thirumalai wrote:
> 2. Change the core ide code to use hwgroup->lock instead of ide_lock.
> Deprecate ide_lock (patch 2)

hwgroups and IDE locking requirements are frequently completely
unrelated. Its clear from the changes proposed you've not tested on real
hardware for each case and you have not studied the documented errata
even for the controllers that are publically specified. This is peoples
data you are endangering, not just risking the odd crash.

> patches -- this is done now for piix controller only.  Eventually, 
> we can change all controllers to remove ide_lock

You could start by fixing the real locking bugs. Or at least trying to
get known fixes past the maintainer and going from there.

Alan

