Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276032AbRJKLNS>; Thu, 11 Oct 2001 07:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276052AbRJKLNJ>; Thu, 11 Oct 2001 07:13:09 -0400
Received: from trantor.dso.org.sg ([192.190.204.1]:58846 "EHLO
	trantor.dso.org.sg") by vger.kernel.org with ESMTP
	id <S276032AbRJKLMy>; Thu, 11 Oct 2001 07:12:54 -0400
Date: Thu, 11 Oct 2001 19:15:35 +0800
From: Richard Shih-Ping Chan <cshihpin@dso.org.sg>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Shih-Ping Chan <cshihpin@dso.org.sg>, linux-kernel@vger.kernel.org
Subject: Re: -ac10,-ac11 no boot on SMP PentiumII box
Message-ID: <20011011191535.D1174@cshihpin.dso.org.sg>
In-Reply-To: <20011011165636.B1174@cshihpin.dso.org.sg> <E15rcC2-0002cu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15rcC2-0002cu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 11, 2001 at 10:31:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I confirm its a gcc interaction

kernel 2.4.10-ac11
CONFIG_X86_PPRO_FENCE defined

gcc-2.96-96 from rawhide OK!
gcc-3.0.1 with Linus tree spinlock.h OK!
gcc-3.0.1 with Alan tree spinlock.h  BIG FREEZE :(((

Thanks. 

On Thu, Oct 11, 2001 at 10:31:54AM +0100, Alan Cox wrote:
> > I've narrowed it down to the change between 2.4.10-ac8 and 
> > -ac9. Maybe it has something to do with CONFIG_X86_PPRO_FENCE?
> 
> That is the obvious candidate. I changed spin_unlock for the ppro to cover
> an errata. It seems to work for me with gcc 2.96 but its asm so its possible
> I've done something some compiler version didnt like.
> 
> Switch the include/asm-i386/spinlock,h to the one in Linus tree and see
> what happens
> -

-- 
Richard Chan <cshihpin@dso.org.sg>
DSO National Laboratories
20 Science Park Drive
Singapore 118230
Tel: 7727045
Fax: 7766476
