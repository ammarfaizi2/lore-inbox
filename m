Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132469AbQL1WN4>; Thu, 28 Dec 2000 17:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132261AbQL1WNg>; Thu, 28 Dec 2000 17:13:36 -0500
Received: from monza.monza.org ([209.102.105.34]:16145 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132027AbQL1WN0>;
	Thu, 28 Dec 2000 17:13:26 -0500
Date: Thu, 28 Dec 2000 13:42:44 -0800
From: Tim Wright <timw@splhi.com>
To: Paul Jakma <paulj@itg.ie>
Cc: Ian Stirling <root@mauve.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
Message-ID: <20001228134244.A1684@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Paul Jakma <paulj@itg.ie>,
	Ian Stirling <root@mauve.demon.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <200012261952.TAA11390@mauve.demon.co.uk> <Pine.LNX.4.30.0012271620530.24075-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012271620530.24075-100000@rossi.itg.ie>; from paulj@itg.ie on Wed, Dec 27, 2000 at 04:23:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2000 at 04:23:43PM +0000, Paul Jakma wrote:
> On Tue, 26 Dec 2000, Ian Stirling wrote:
> 
> > The PCI bus can move around 130MB/sec,
> 
> in bursts yes, but sustained data bandwidth of PCI is a lot lower,
> maybe 30 to 50MB/s. And you won't get sustained RAID performance >
> sustained PCI performance.
> 

No. A well-designed card and driver doing cache-line sized transfers can
achieve ~100MB/s. On the IBM (Sequent) NUMA machines, we achieved in excess
of 3GB/s sustained read I/O (database full table scan) on a 16-quad (32 PCI
bus) system. That works out at around 100MB/s per bus.

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
