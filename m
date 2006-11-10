Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424392AbWKJL2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424392AbWKJL2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424391AbWKJL2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:28:33 -0500
Received: from mx1.suse.de ([195.135.220.2]:30860 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1424393AbWKJL2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:28:32 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Fri, 10 Nov 2006 12:28:27 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <200611101147.26081.ak@suse.de> <1163156158.3138.677.camel@laptopd505.fenrus.org>
In-Reply-To: <1163156158.3138.677.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101228.28112.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 11:55, Arjan van de Ven wrote:

> > 
> > Most systems don't have C3 right now. And on those that have
> > (laptops) it tends to be not that critical because they normally
> > don't run workload where gettimeofday() is really time critical
> > (and nobody expects them to be particularly fast anyways)
> 
> and that got changed when the blade people decided to start using laptop
> processors ......

Well those will be handled eventually. Currently they just have
a slower gettimeofday.

But the majority of systems is not impacted.

BTW if someone really wants to have fast gettimeofday on a blade
they can just disable C3 and force TSC.

-Andi
