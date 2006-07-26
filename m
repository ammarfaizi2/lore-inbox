Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWGZVmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWGZVmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWGZVmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:42:25 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:25545 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030310AbWGZVmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:42:24 -0400
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be
	totally bizare
From: Arjan van de Ven <arjan@linux.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607261422110.4168@g5.osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
	 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
	 <20060725185449.GA8074@elte.hu>
	 <1153855844.8932.56.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org>
	 <1153921207.3381.21.camel@laptopd505.fenrus.org>
	 <20060726155114.GA28945@redhat.com>
	 <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org>
	 <1153942954.3381.50.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org>
	 <20060726205810.GB23488@in.ibm.com>
	 <Pine.LNX.4.64.0607261422110.4168@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 23:38:47 +0200
Message-Id: <1153949927.3381.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Do we have lockdep warnings remaining? I'd hope that Arjan's earlier patch 
> (the one I already applied) got all of those, and that we at least thus 
> would have some basis for the belief that we got the ABBA deadlocks fixed.

I've not seen lockdep warnings with my patch; I tend to run with lockdep
on always nowadays ;)

