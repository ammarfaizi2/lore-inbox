Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVJVK6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVJVK6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 06:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVJVK6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 06:58:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27583 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932226AbVJVK6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 06:58:20 -0400
Date: Sat, 22 Oct 2005 11:58:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached PHYs)
Message-ID: <20051022105815.GB3027@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-scsi@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
	Christoph Hellwig <hch@lst.de>,
	"Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
	Linus Torvalds <torvalds@osdl.org>
References: <4359395B.9030402@pobox.com> <43593FE1.7020506@adaptec.com> <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435A1793.1050805@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2005 at 12:42:27PM +0200, Stefan Richter wrote:
> A. Post mock-ups and pseudo code about how to change the core, discuss.
> B. Set up a scsi-cleanup tree. In this tree,
>      1. renovate the core (thereby break all command set drivers and
>         all transport subsystems),

No way.  Doing things from scatch is a really bad idea.  See how far we came
with Linux 2.6 scsi vs 2.4 scsi without throwing everything away and break the
world.  Please submit changes to fix _one_ thing at a time and fix all users.
Repeat until done or you don't care anymore.
