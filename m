Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQL2RBV>; Fri, 29 Dec 2000 12:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2RBK>; Fri, 29 Dec 2000 12:01:10 -0500
Received: from monza.monza.org ([209.102.105.34]:32261 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129345AbQL2RBC>;
	Fri, 29 Dec 2000 12:01:02 -0500
Date: Fri, 29 Dec 2000 08:30:14 -0800
From: Tim Wright <timw@splhi.com>
To: Mark Hemment <markhe@veritas.com>
Cc: "David S. Miller" <davem@redhat.com>, ak@suse.de, torvalds@transmeta.com,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
Message-ID: <20001229083014.A3096@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Mark Hemment <markhe@veritas.com>,
	"David S. Miller" <davem@redhat.com>, ak@suse.de,
	torvalds@transmeta.com, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <200012282233.OAA01433@pizda.ninka.net> <Pine.LNX.4.21.0012291533000.3592-100000@alloc.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012291533000.3592-100000@alloc.wat.veritas.com>; from markhe@veritas.com on Fri, Dec 29, 2000 at 03:46:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 03:46:22PM +0000, Mark Hemment wrote:
>   Note, for those of us running on 32bit with lots of physical memory, the
> available virtual address-space is of major consideration.  Reducing the
> size of the page structure is more than just reducing cache misses - it
> gives us more virtual to play with...
> 
> Mark
> 

Yes, this is a very important point if we ever want to make serious use
of large memory machines on ia32. We ran into this with DYNIX/ptx when the
P6 added 36-bit physical addressing. Conserving KVA (kernel virtual address
space), became a very high priority. Eventually, we had to add code to play
silly segment games and "magically" materialize and dematerialize a 4GB
kernel virtual address space instead of the 1GB. This only comes into play
with really large amounts of memory, and is almost certainly not worth the
agony of implementation on Linux, but we'll need to be careful elsewhere to
conserve it as much as possible.

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
