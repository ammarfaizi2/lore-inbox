Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVGLKgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVGLKgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVGLKgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:36:15 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:50347 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261327AbVGLKgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:36:07 -0400
In-Reply-To: <200507121322.09610.vda@ilport.com.ua>
Subject: Re: [patch 7/12] s390: fba dasd i/o errors.
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: akpm@osdl.org, Horst Hummel <horst.hummel@de.ibm.com>,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF4C6CD4B3.003279A6-ON4225703C.0039E4A7-4225703C.003A3B95@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 12 Jul 2005 12:36:03 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 12/07/2005 12:36:04
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -354,6 +354,8 @@ dasd_fba_build_cp(struct dasd_device * d
> >          }
> >          cqr->device = device;
> >          cqr->expires = 5 * 60 * HZ;         /* 5 minutes */
> > +        cqr->retries = 32;
>
> 2..4 maybe, but 32? This isn't tiny by any account.

Are you arguing the use of the adjective "tiny" or the technical
aspects of using 32 as the number of retries for dasd fba?
In the dasd driver we use a retry count of 255 as "standard", so
32 is indeed much smaller than that. If you can call it tiny,
well who cares??

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


