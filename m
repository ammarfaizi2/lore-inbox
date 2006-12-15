Return-Path: <linux-kernel-owner+w=401wt.eu-S1752787AbWLOQCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbWLOQCM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbWLOQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:02:12 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:40833 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbWLOQCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:02:10 -0500
Subject: Re: [2.6 patch] remove the broken SCSI_SEAGATE driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <m3wt4tp9ka.fsf@defiant.localdomain>
References: <20061212162238.GR28443@stusta.de>
	 <1165966274.5903.56.camel@mulgrave.il.steeleye.com>
	 <20061213000902.GD28443@stusta.de>  <m3wt4tp9ka.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 10:00:54 -0600
Message-Id: <1166198454.2846.10.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 14:34 +0100, Krzysztof Halasa wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > There must have been a compile error that has since been fixed, but I 
> > don't remember the details of this specific driver and I don't have 
> > such old compile logs anymore.
> 
> I wonder if we could gather some usage statistics, especially WRT
> really old hardware.
> 
> Perhaps we could invent some MODULE_WARN_OBSOLETE thing which would
> warn users about their drivers being removed in +6m (or maybe +12m),
> unless they let us know at http://qwe or mailto:ads?
> 
> I find it really hard to believe there are still users of things like
> CDU-31A CDs, XT MFM disk controllers, or NCR5380 SCSI host adapters
> (especially the real ones, not DOMEX etc. clones bundled with scanner
> just ~ 10 years ago).

I really don't see a need to declare drivers obsolete unless they bitrot
to the point they're demonstrably useless and no-one wants to step up to
fix them, which is what the BROKEN flag is for.

James


