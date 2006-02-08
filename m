Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030596AbWBHQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbWBHQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbWBHQ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:56:59 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:54226 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161106AbWBHQ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:56:58 -0500
Subject: Re: [patch 05/10] s390: add missing validation for dasd discipline
	specific ioctls
From: Horst Hummel <horst.hummel@de.ibm.com>
Reply-To: horst.hummel@de.ibm.com
To: Christoph Hellwig <hch@lst.de>
Cc: Martin <mschwid2@de.ibm.com>, kernel <linux-kernel@vger.kernel.org>,
       Stefan Weinhuber <wein@de.ibm.com>, heiko <heicars2@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 17:56:59 +0100
Message-Id: <1139417819.5945.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote on 08.02.2006 15:08:39:

> On Wed, Feb 08, 2006 at 01:37:09PM +0100, Heiko Carstens wrote:
> > From: Horst Hummel <horst.hummel@de.ibm.com>
> > 
> > Because of missing discipline validition dasd ioctls calls may not
return
> > when called on a device handled by a different discipline.
> > (e.g calling ECKD specific BIODASDGATTR on an FBA device).
> > This addresses one of the issues Christoph has with the dasd driver.
> 
> Nack.  the right way to do this is to have per-discipline ioctl
methods,
> even if we can't remove the dasd_ioctl_register interface yet due to
> other disagreements.  Just resurect those parts of my patch.
> 
As I already tried to explain, the DASD ioctls are _not_ discipline
related. A discipline is more or less a 'access method to a physical 
DASD'. Sine the ioctls are related to 'functional components', each
ioctl could be valid in combination with none, one, two or every of
the currently supported disciplines (ECKD, FBA, DIAG).


