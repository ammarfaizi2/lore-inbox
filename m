Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRDJRX7>; Tue, 10 Apr 2001 13:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbRDJRXt>; Tue, 10 Apr 2001 13:23:49 -0400
Received: from ns.suse.de ([213.95.15.193]:55561 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129408AbRDJRXc>;
	Tue, 10 Apr 2001 13:23:32 -0400
Date: Tue, 10 Apr 2001 19:23:28 +0200
From: Andi Kleen <ak@suse.de>
To: Imran.Patel@nokia.com
Cc: ak@suse.de, netfilter-devel@us5.samba.org, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: skb allocation problems
Message-ID: <20010410192328.A21887@gruyere.muc.suse.de>
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF0D@eseis15nok>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF0D@eseis15nok>; from Imran.Patel@nokia.com on Tue, Apr 10, 2001 at 07:27:29PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 07:27:29PM +0300, Imran.Patel@nokia.com wrote:
> > On Mon, Apr 09, 2001 at 07:03:46PM +0300, Imran.Patel@nokia.com wrote:
> > > I have written a test module which closely mirrors what my 
> > code tries to
> > > do(attached below). This is what i get:
> > > 
> > > PRE_R: old skb:c371ee40  new skb:c371ee30 
> > 
> > I guess oldskb->len is <=0xc, and the slab allocator packs 
> > them near together
> > in the same zone.
> 
> nope. i have checked it, the length of the older skb is perfectly ok.....and
> i even found that this weird behaviour happens only when the old skb buffer
> length is between 80 and 224 bytes. 

Well, I don't know then. You have to debug it. It's probably something stupid
(if fundamental services like alloc_skb/kfree_skb were completely buggy
someone surely would have noticed earlier)

-Andi
