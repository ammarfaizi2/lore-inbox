Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbRELRkn>; Sat, 12 May 2001 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbRELRkd>; Sat, 12 May 2001 13:40:33 -0400
Received: from ns.suse.de ([213.95.15.193]:19975 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261301AbRELRkY>;
	Sat, 12 May 2001 13:40:24 -0400
Date: Sat, 12 May 2001 19:40:04 +0200
From: Andi Kleen <ak@suse.de>
To: Alexey Vyskubov <alexey.vyskubov@nokia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about ipip implementation
Message-ID: <20010512194004.A1091@gruyere.muc.suse.de>
In-Reply-To: <20010511173940.A418@Hews1193nrc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010511173940.A418@Hews1193nrc>; from alexey.vyskubov@nokia.com on Fri, May 11, 2001 at 05:39:40PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 05:39:40PM +0300, Alexey Vyskubov wrote:
> Hello!
> 
> I read net/ipv4/ipip.c. It seems to me that ipip_rcv() function after
> "unwrapping" tunelled IP packet creates "virtual Ethernet header" and submit
> corresponding sk_buff to netif_rx().
> 
> Is there a some reason to do things this way instead of calling ip_rcv() for
> "unwrapped" IP packet?

e.g. packet sockets still work and it doesn't break the layering.


-Andi

