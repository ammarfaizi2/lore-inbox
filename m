Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWFBBPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWFBBPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWFBBPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:15:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:31083 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751059AbWFBBPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:15:21 -0400
X-IronPort-AV: i="4.05,200,1146466800"; 
   d="scan'208"; a="44659567:sNHT21915393234"
Subject: Re: State of resume for AHCI?
From: "zhao, forrest" <forrest.zhao@intel.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jens Axboe <axboe@suse.de>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
In-Reply-To: <447F4BC2.8060808@goop.org>
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>
	 <20060601183904.GR4400@suse.de>  <447F4BC2.8060808@goop.org>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 09:02:45 +0800
Message-Id: <1149210165.13451.4.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2006 01:14:30.0828 (UTC) FILETIME=[E68576C0:01C685E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 13:19 -0700, Jeremy Fitzhardinge wrote:
> Jens Axboe wrote:
> > It's a lot more complicated than that, I'm afraid. ahci doesn't even
> > have the resume/suspend methods defined, plus it needs more work than
> > piix on resume.
> >   
> Hannes Reinecke's patch implements those functions, basically by 
> factoring out the shutdown and init code and calling them at 
> suspend/resume time as well.
> 
> Is that correct/sufficient?  Or should something else be happening?

According to our test of Hannes's patch, it's not sufficient to support
AHCI suspend/resume.

Now I'm writing a patch to try to provide complete support for AHCI
suspend/resume and will send out patch soon, hopefully by the end of
today.

Thanks,
Forrest
