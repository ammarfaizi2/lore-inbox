Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWGJIu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWGJIu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWGJIu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:50:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54503 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751362AbWGJIuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:50:25 -0400
Subject: Re: 2.6.18-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Fabio Comolli <fabio.comolli@gmail.com>,
       mingo@redhat.com, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>, Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <44B0F87F.70503@yahoo.com.au>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <b637ec0b0607090326w5a1702d1l9b7619fba7e4bc41@mail.gmail.com>
	 <20060709034509.c4652caa.akpm@osdl.org>  <44B0F87F.70503@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 10:50:19 +0200
Message-Id: <1152521419.4874.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - If a piece of kernel code is dealing with per-cpu data and cannot run
> >   atomically then it should have its own cpu hotplug handlers anyway.  It
> >   is up to that code (ie: cpufreq) to provide its own locking against its
> >   own CPU hotplug callback.
> 
> This still does not solve this cpufreq problem where it is trying to
> take the same lock twice down the same call path.

that is broken beyond discussing anyway... "we don't know our locking
rules so we do recursive mutexes" is ... NOT a good reason.


