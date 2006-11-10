Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946406AbWKJKrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946406AbWKJKrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946407AbWKJKrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:47:36 -0500
Received: from ns.suse.de ([195.135.220.2]:4741 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946406AbWKJKrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:47:36 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Fri, 10 Nov 2006 11:47:25 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061110011336.008840cf.akpm@osdl.org> <1163154958.3138.671.camel@laptopd505.fenrus.org>
In-Reply-To: <1163154958.3138.671.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101147.26081.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 11:35, Arjan van de Ven wrote:
> 
> > We're limping along in a semi-OK fashion with the TSC. 
> 
> that's because we fake it a heck of a lot; like after C3 we just make
> the kernel guestimate how much to progress it so that it has just enough
> ductape on it to not totally fall apart ;(

Do we? Where?  AFAIK we just do some resetting after cpu frequency
changes, but on C3 TSC is just disabled globally.

That is better than it sounds.

Most systems don't have C3 right now. And on those that have
(laptops) it tends to be not that critical because they normally
don't run workload where gettimeofday() is really time critical
(and nobody expects them to be particularly fast anyways)

[... proposal for per CPU TSC state snipped ...]

All is being worked on.

-Andi
