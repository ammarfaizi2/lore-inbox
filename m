Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285304AbRLFX1K>; Thu, 6 Dec 2001 18:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285307AbRLFX1D>; Thu, 6 Dec 2001 18:27:03 -0500
Received: from bitmover.com ([192.132.92.2]:57477 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285304AbRLFX04>;
	Thu, 6 Dec 2001 18:26:56 -0500
Date: Thu, 6 Dec 2001 15:26:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@redhat.com, lm@bitmover.com, phillips@bonn-fries.net,
        davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206152654.S27589@work.bitmover.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
	lm@bitmover.com, phillips@bonn-fries.net, davidel@xmailserver.org,
	rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com,
	riel@conectiva.com.br, lars.spam@nocrew.org,
	alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206122116.H27589@work.bitmover.com> <20011206.130202.107681970.davem@redhat.com> <20011206172708.B31752@redhat.com> <20011206.150847.45874365.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011206.150847.45874365.davem@redhat.com>; from davem@redhat.com on Thu, Dec 06, 2001 at 03:08:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 03:08:47PM -0800, David S. Miller wrote:
>    From: Benjamin LaHaise <bcrl@redhat.com>
>    Date: Thu, 6 Dec 2001 17:27:08 -0500
> 
>    	- lower overhead for SMP systems.  We can use UP kernels local 
>    	  to each CPU.  Should make kernel compiles faster. ;-)
>    
> Actually, this isn't what is being proposed.  Something like
> "4 cpu" SMP kernels.

I personally want to cluster small SMP OS images because I don't want to
do the process migration crap anywhere except at exec time, it simplifies
a lot.  So I need a second order load balancing term that I can get
from 2 or 4 way smp nodes.  If you are willing to process migration to
handle load imbalances, then you could do uniprocessor only.  I think
the complexity tradeoff is in favor of the small SMP OS clusters, we
already have them.  Process migration is a rats nest.

>    At the very least it is well worth investigating.  Bootstrapping the 
>    ccCluster work shouldn't take more than a week or so, which will let 
>    us attach some hard numbers to the kind of impact it has on purely 
>    cpu local tasks.
>    
> I think it is worth considering too, but I don't know if a week
> estimate is sane or not :-)

Yeah, it's possible that you could get something booting in a week but I
think it's a bit harder than that too.  One idea that was kicked around
was to use Jeff's UML work and "boot" multiple UML's on top of a virtual
SMP.  You get things to work there and then do a "port" to real hardware.
Kind of a cool idea if you ask me.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
