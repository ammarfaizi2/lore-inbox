Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132742AbRDKS3k>; Wed, 11 Apr 2001 14:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132879AbRDKS3V>; Wed, 11 Apr 2001 14:29:21 -0400
Received: from ns.suse.de ([213.95.15.193]:18188 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132912AbRDKS3G>;
	Wed, 11 Apr 2001 14:29:06 -0400
Date: Wed, 11 Apr 2001 20:28:31 +0200
From: Andi Kleen <ak@suse.de>
To: Imran.Patel@nokia.com
Cc: ak@suse.de, netfilter-devel@us5.samba.org, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: skb allocation problems (More Brain damage!)
Message-ID: <20010411202831.A15029@gruyere.muc.suse.de>
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF2D@eseis15nok>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2D6CADE9B0C6D411A27500508BB3CBD063CF2D@eseis15nok>; from Imran.Patel@nokia.com on Wed, Apr 11, 2001 at 08:15:49PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 08:15:49PM +0300, Imran.Patel@nokia.com wrote:
> And as a I said earlier, only ping packets with size within certain range
> create this problem......Something is terribly wrong here!! But as I am not
> a Linux mm guru, i can't tell what is wrong here!

What you can try is to turn on slab debugging. Set the  FORCED_DEBUG
define in mm/slab.c to one and recompile. Does it change any pattern
when you dump the data in the skbs or pings? 
If yes someone is playing with already freed packets.

Furthermore you can instrument other parts with good old printk.

And what NIC are you using btw?


-Andi
