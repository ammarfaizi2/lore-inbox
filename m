Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269031AbUI2VTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269031AbUI2VTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUI2VTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:19:50 -0400
Received: from p5089E8E5.dip.t-dialin.net ([80.137.232.229]:3588 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S269031AbUI2VSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:18:45 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.9-rc2-mm4 drm and XFree oopses
Date: Wed, 29 Sep 2004 23:18:41 +0200
User-Agent: KMail/1.7
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dave Airlie <airlied@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20040929102840.GA11325@none> <200409292143.18847.vda@port.imtp.ilyichevsk.odessa.ua> <1096484185.1600.50.camel@krustophenia.net>
In-Reply-To: <1096484185.1600.50.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409292318.41640.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 20:56, Lee Revell wrote:
> On Wed, 2004-09-29 at 14:43, Denis Vlasenko wrote:
> > On Wednesday 29 September 2004 15:28, Dave Airlie wrote:
> > > It might help if you enabled AGP for your chipset, you have no agp
> > > compiled in for your Intel motherboard, you need intel agp chipset
> > > support..
> >
> > However kernel shouldn't use using smp_processor_id() in preemptible
> > regions, with or without Intel AGP support compuled in.
> >
I wonder _who_ is the user of smp_processor_id() in this case?
> > > > Sep 29 12:03:07 zmei kernel: [drm:radeon_cp_init] *ERROR*
> > > > radeon_cp_init called without lock held Sep 29 12:03:07 zmei kernel:
> > > > [drm:radeon_unlock] *ERROR* Process 2807 using kernel context 0 Sep
> > > > 29 12:03:07 zmei kernel: using smp_processor_id() in preemptible
> > > > code: XFree86/2807
>
> It looks like that code that uses smp_processor_id assumes that it has
> the DRM lock, but for whatever reason you don't have it.
>
> Lee

However, the above error concerning drm disappears after compiling in AGP. 
What remains is the oops...

Regards,
Boris.
