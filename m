Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268620AbTGIX1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268682AbTGIX1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:27:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27826
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268620AbTGIX04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:26:56 -0400
Subject: Re: [PATCH] Readd BUG for SMP TLB IPI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030709193246.059ee57d.ak@suse.de>
References: <20030709124915.3d98054b.ak@suse.de>
	 <1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
	 <20030709134109.65efa245.ak@suse.de>
	 <1057769607.6262.63.camel@dhcp22.swansea.linux.org.uk>
	 <20030709185823.1f243367.ak@suse.de>
	 <1057770255.6255.70.camel@dhcp22.swansea.linux.org.uk>
	 <20030709193246.059ee57d.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057793934.7138.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 00:38:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 18:32, Andi Kleen wrote:
> > > How do you know it an happen on them? Do you have backtraces?
> > 
> > I sat down with a BP6 owner and did lots of debugging.
> 
> I meant on the not known-to-be-nearly-unusable boards. Or are you saying that
> on the other boards the APIC bus could be lossy too, but it's very unlikely? 
> [my personal feeling would be to consider the lossy APIC bus to be a hardware
> problem, like an MCE that cannot be really handled] 

APIC errors can occur on any box. The checksum ensures they get
retransmitted but does mean you can ger replay of events

> I suspect when you have a lossy APIC bug you will run into problems with other IPIs too,
> it's really an uphill fight which you are likely to lose.

If you follow intels recommendations it ought to just work. Its basically about 
checking if the message is one you processed and not repeating the execution

