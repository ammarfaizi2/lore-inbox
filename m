Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755152AbWKMQhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbWKMQhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755154AbWKMQhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:37:43 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:5578 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1755152AbWKMQhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:37:42 -0500
In-Reply-To: <17748.15442.906060.210242@cargo.ozlabs.ibm.com>
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page
 mapping in 64k page mode
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, openib-general-bounces@openib.org,
       "Roland Dreier" <rdreier@cisco.com>
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OFEBD51474.F7DD1031-ONC1257225.0032352E-C1257225.005B569D@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 13 Nov 2006 17:40:52 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 13/11/2006 17:40:53
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Christoph Raisch writes:
>
> > The patch is needed. We've seen it on the real system. We did fix it on
the
> > real system.
>
> I disagree that the ioremap change is needed.
>
> > ...and it conforms to theory... although theory is a bit confusing
here.
> >
> > let me try to summarize:
> > ioremap checks for 64k boundary (actually page boundary)
>
> Actually, ioremap itself already does the calculations that your patch
> adds - that is, it generates the offset within the page and the
> physical address of the start of the page, does the mapping using the
> latter, then adds on the offset to the virtual address of the page and
> returns that.

Paul,
you are right. The calculation is done in your code already.
We can't reproduce the problem anymore on latest kernel.
Was this calculation there in ioremap right from the start with 64k on
POWER or added later on?

So Roland, feel free to ignore that line where we do the calculation.

>
> Paul.

