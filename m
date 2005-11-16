Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbVKPPic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbVKPPic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbVKPPic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:38:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18389 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751475AbVKPPib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:38:31 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: jmerkey <jmerkey@utah-nac.org>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andi Kleen <ak@suse.de>, alex14641@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511161630.59588.oliver@neukum.org>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
	 <20051116135116.GA24753@wohnheim.fh-wedel.de>
	 <437B453E.8070905@utah-nac.org>  <200511161630.59588.oliver@neukum.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:38:01 +0100
Message-Id: <1132155482.2834.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 16:30 +0100, Oliver Neukum wrote:
> Am Mittwoch, 16. November 2005 15:42 schrieb jmerkey:
> > Map a blank ro page beneath the address range when stack memory is 
> > mapped is trap on page faults to the page when folks go off the end of 
> > th e stack.
> > 
> > Easy to find.
> 
> Provided you can easily trigger it. I don't see how that is a given.

the same is true for a unified 8k stack or for the 4k/4k split though.
Ok sure there's a 1.5Kb difference on the one side.. (but a 2Kb gain on
the other side)



