Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVE3Dlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVE3Dlo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 23:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVE3Dlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 23:41:44 -0400
Received: from stark.xeocode.com ([216.58.44.227]:36224 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261509AbVE3Dln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 23:41:43 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ support
References: <20050527070353.GL1435@suse.de>
	<20050527131842.GC19161@merlin.emma.line.org>
	<20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de>
	<20050527145821.GX1435@suse.de>
In-Reply-To: <20050527145821.GX1435@suse.de>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 29 May 2005 23:41:31 -0400
Message-ID: <87oeatxtw4.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> SATA is still pretty fast without NCQ, 
...
> People have lived happily without NCQ support in SATA for years, I'm
> sure you could too :-)

It kind of depends on your application. For applications that require write
caching disabled like Postgres et al I suspect NCQ will make a *much* bigger
difference.

I would be interested to see those benchmarks people were posting earlier
claiming 30-40% difference retested with write caching disabled. I suspect
disabling write caching will demolish the non-NCQ performance but have a much
smaller effect on NCQ-enabled performance.

Currently Postgres strongly recommends SCSI drives and the belief is that it's
the tagged command queuing that allows SCSI drives to perform well without
resorting to data integrity destroying write caching.

-- 
greg

