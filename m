Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWAZSXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWAZSXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWAZSXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:23:20 -0500
Received: from mx.pathscale.com ([64.160.42.68]:58343 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932392AbWAZSXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:23:20 -0500
Subject: Re: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: eranian@hpl.hp.com
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060126054345.GC10962@frankl.hpl.hp.com>
References: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com>
	 <1137775645.28944.61.camel@serpentine.pathscale.com>
	 <20060124150912.GB7130@frankl.hpl.hp.com>
	 <1138219693.15295.13.camel@serpentine.pathscale.com>
	 <20060125235204.GB21195@kroah.com>
	 <20060126045510.GA10962@frankl.hpl.hp.com>
	 <20060126052419.GB12538@kroah.com>
	 <20060126054345.GC10962@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 10:23:13 -0800
Message-Id: <1138299793.12632.46.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 21:43 -0800, Stephane Eranian wrote:

> This one contains statistics about perfmon such as PMU model, number of active
> sessions, and also a bunch of per-cpu statistics (see attached file).
> 
> $ cat /proc/perfmon
> perfmon version            : 2.2
> PMU model                  : Intel Pentium M
> PMU description version    : 1.0
> counter width              : 31
> loaded per-thread sessions : 0
> loaded sys-wide   sessions : 0
> current smpl buffer memory : 0
> format                     : d1-39-b2-9e-62-e8-40-e4-b4-02-73-07-87-92-e9-37 default_format2
> CPU0   total ovfl intrs    : 0
> CPU0     spurious intrs    : 0
> CPU0     replay   intrs    : 0
> CPU0     regular  intrs    : 0
> CPU0   overflow cycles     : 0
> CPU0   overflow phase1     : 0
> CPU0   overflow phase2     : 0
> CPU0   overflow phase3     : 0
> CPU0   smpl handler calls  : 0
> CPU0   smpl handler cycles : 0
> CPU0   set switch count    : 0
> CPU0   set switch cycles   : 0
> CPU0   handle timeout      : 0
> CPU0   owner task          : -1
> CPU0   owner context       : 00000000
> CPU0   activations         : 0

Is there any reason you might need those per-CPU statistics in an atomic
snapshot form?  That seems unlikely, off the top of my head.  You could
either have a per-CPU directory with a file for each counter, which
seems cleanest, or a per-CPU file with all counters and the name of
each, although the format wants cleaning compared to what you have now.

	<b

