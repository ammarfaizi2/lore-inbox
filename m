Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbUDGWwC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbUDGWwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:52:01 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21435
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264194AbUDGWu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:50:59 -0400
Date: Thu, 8 Apr 2004 00:50:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407225057.GS26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406172431.GA9185@elte.hu> <20040406175722.GE2234@dualathlon.random> <10680000.1081378467@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10680000.1081378467@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 03:54:27PM -0700, Martin J. Bligh wrote:
> Or was this another workload, where gettimeofday wasn't the problem?

mysql is another common -30% slowdown where gettimeofday shouldn't be
the problem.  Any threaded application doing I/O should have major
scalability problems with 4:4 regardless the tlb flushing frequency, the
more cpus the biggest the hit (I should say mm_switch frequency [not tlb
flush frequency] after my latest benchmark results)
