Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRB0AEW>; Mon, 26 Feb 2001 19:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRB0AEC>; Mon, 26 Feb 2001 19:04:02 -0500
Received: from ns.suse.de ([213.95.15.193]:39696 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129268AbRB0AD6>;
	Mon, 26 Feb 2001 19:03:58 -0500
Date: Tue, 27 Feb 2001 01:03:36 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: New net features for added performance
Message-ID: <20010227010336.A25816@gruyere.muc.suse.de>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <oupsnl3k5gs.fsf@pigdrop.muc.suse.de> <15002.60239.486243.682681@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15002.60239.486243.682681@pizda.ninka.net>; from davem@redhat.com on Mon, Feb 26, 2001 at 03:48:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 03:48:31PM -0800, David S. Miller wrote:
> 
> Andi Kleen writes:
>  > 4) Better support for aligned RX by only copying the header
> 
> Andi you can make this now:
> 
> 1) Add new "post-header data pointer" field in SKB.

That would imply to let the drivers parse all headers to figure out the length.
I think it's better to have a "header base" and "data base" pointer.
The driver would just copy some standard size that likely contains all of
the header 
When you're finished with the header use 
skb->database+(skb->hdrptr-skb->hdrbase) to get the start of data. 

Or did I misunderstand you?



> 3) Enforce correct usage of it in all the networking :-)

,) -- the tricky part.


-Andi
