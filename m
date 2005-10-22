Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVJVRTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVJVRTz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVJVRTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:19:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16351 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750790AbVJVRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:19:54 -0400
Date: Sat, 22 Oct 2005 18:19:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Panov <sipan@sipan.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached PHYs)
Message-ID: <20051022171943.GA7546@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sergey Panov <sipan@sipan.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-scsi@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
	Christoph Hellwig <hch@lst.de>,
	"Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
	Linus Torvalds <torvalds@osdl.org>
References: <4359440E.2050702@pobox.com> <43595275.1000308@adaptec.com> <435959BE.5040101@pobox.com> <43595CA6.9010802@adaptec.com> <43596070.3090902@pobox.com> <43596859.3020801@adaptec.com> <43596F16.7000606@pobox.com> <435A1793.1050805@s5r6.in-berlin.de> <20051022105815.GB3027@infradead.org> <1129994910.6286.21.camel@sipan.sipan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129994910.6286.21.camel@sipan.sipan.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2005 at 11:28:30AM -0400, Sergey Panov wrote:
>  It is a mistake to think that you can not do a big rework and keep SCSI
> sub-system stable. You just have to make sure the OLD way is supported
> for as log as it is needed.

No.  Rewriting something from scratch is horrible engineering practice.
It's impossible to very huge changes, small incremental changes OTOH
allow easier planning, easier calculation of the risks and cost and most
import better test coverage.  There's nothing specific to scsi or linux
kernel code about it.  It'd suggest you read:

 http://www.joelonsoftware.com/articles/fog0000000069.html

or various similar articles.  Full scale rewrites almost never work
out.
