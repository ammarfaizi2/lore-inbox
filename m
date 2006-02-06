Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWBFLan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWBFLan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWBFLan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:30:43 -0500
Received: from ns1.suse.de ([195.135.220.2]:43752 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750926AbWBFLam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:30:42 -0500
Date: Mon, 6 Feb 2006 12:30:46 +0100
From: Jan Blunck <jblunck@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Stefan Weinhuber <wein@de.ibm.com>,
       Horst Hummel <horst.hummel@de.ibm.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] s390: dasd extended error reporting module.
Message-ID: <20060206113046.GC5564@hasse.suse.de>
References: <20060201115649.GA9361@osiris.boeblingen.de.ibm.com> <4de7f8a60602060237o5c19d796hb08c237a9b5f3c64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4de7f8a60602060237o5c19d796hb08c237a9b5f3c64@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, Heiko Carstens wrote:

> From: Stefan Weinhuber <wein@de.ibm.com>
> 
> The DASD extended error reporting is a facility that allows to
> get detailed information about certain problems in the DASD I/O.
> This information can be used to implement fail-over applications
> that can recover these problems.
> This is a resubmit of this patch because at first submission it
> didn't get included due to Christoph's ioctl changes.
> Since these aren't in the -mm tree anymore this one should be
> merged now.

Why don't you use the sysfs for this purpose? This new character device
interface seems very odd to me. Why don't you introduce new attributes to the
dasd device for that purpose and make online pollable for failovers?

Or use dm-netlink to report the extended errors via multipath to the user
space.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
