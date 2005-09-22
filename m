Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVIVODm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVIVODm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVIVODl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:03:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10382 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030358AbVIVODk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:03:40 -0400
Subject: Re: SATA suspend-to-ram patch - merge?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050922135607.GK4262@suse.de>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>
	 <20050922061849.GJ7929@suse.de>
	 <1127398679.18840.84.camel@localhost.localdomain>
	 <20050922135607.GK4262@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 15:30:09 +0100
Message-Id: <1127399409.18840.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-22 at 15:56 +0200, Jens Axboe wrote:
> It's a shame for the people not using distros, since they need to first
> experience the suspend failure, then google around for a solution, find
> the patch, etc. That is a shame, since it could have worked out of the
> box since 2.6.12 at least.

Its a symptom of general problems in this area. To get a sane kernel you
have to not only pick a distro kernel right now but then add several
other patches only found in other distributions.

SCSI suspend should not be blocking SATA suspend. If SCSI isn't with the
program yet then SCSI should just not support suspend while allowing
SATA to do so.

Alan

