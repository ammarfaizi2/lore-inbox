Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132746AbRDKSZk>; Wed, 11 Apr 2001 14:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132742AbRDKSZU>; Wed, 11 Apr 2001 14:25:20 -0400
Received: from ns.suse.de ([213.95.15.193]:64267 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132737AbRDKSZS>;
	Wed, 11 Apr 2001 14:25:18 -0400
Date: Wed, 11 Apr 2001 20:25:12 +0200
From: Andi Kleen <ak@suse.de>
To: Bart Trojanowski <bart@jukie.net>
Cc: Imran.Patel@nokia.com, ak@suse.de, netfilter-devel@us5.samba.org,
        netdev@oss.sgi.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: skb allocation problems (More Brain damage!)
Message-ID: <20010411202512.A15011@gruyere.muc.suse.de>
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF2D@eseis15nok> <Pine.LNX.4.30.0104111343380.31460-100000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104111343380.31460-100000@localhost>; from bart@jukie.net on Wed, Apr 11, 2001 at 01:47:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 01:47:18PM -0400, Bart Trojanowski wrote:
> 
> Coudl the problem be in the NIC driver not in the alloc_skb?  I have used
> both 2.4.{1,3} for some time and never seen this corruption.  I use ping
> -f with various packet sizes for stress testing my IPSec boxes... these do
> quite a bit of extra skb creation as an IPSec header sometimes does not
> fit in the original skb.  No problems yet.
> 
> My gut tells me to blame the NIC driver of the NIC itself.

The NIC is not directly involved in alloc_skb() (except maybe if it corrupts
internal data structures of the allocator) 

-Andi
