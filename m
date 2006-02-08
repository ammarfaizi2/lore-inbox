Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWBHOIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWBHOIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWBHOIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:08:48 -0500
Received: from verein.lst.de ([213.95.11.210]:19181 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965148AbWBHOIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:08:46 -0500
Date: Wed, 8 Feb 2006 15:08:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Horst Hummel <horst.hummel@de.ibm.com>,
       Stefan Weinhuber <wein@de.ibm.com>, hch@lst.de
Subject: Re: [patch 05/10] s390: add missing validation for dasd discipline specific ioctls
Message-ID: <20060208140839.GA16366@lst.de>
References: <20060208123709.GF1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208123709.GF1656@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:37:09PM +0100, Heiko Carstens wrote:
> From: Horst Hummel <horst.hummel@de.ibm.com>
> 
> Because of missing discipline validition dasd ioctls calls may not return
> when called on a device handled by a different discipline.
> (e.g calling ECKD specific BIODASDGATTR on an FBA device).
> This addresses one of the issues Christoph has with the dasd driver.

Nack.  the right way to do this is to have per-discipline ioctl methods,
even if we can't remove the dasd_ioctl_register interface yet due to
other disagreements.  Just resurect those parts of my patch.

