Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRDDSTq>; Wed, 4 Apr 2001 14:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRDDSTh>; Wed, 4 Apr 2001 14:19:37 -0400
Received: from [64.64.109.142] ([64.64.109.142]:8206 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S129282AbRDDSTS>;
	Wed, 4 Apr 2001 14:19:18 -0400
Message-ID: <3ACB6524.C5986233@didntduck.org>
Date: Wed, 04 Apr 2001 14:17:08 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vik Heyndrickx <vik.heyndrickx@pandora.be>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernel hangs on 486 machine at boot
In-Reply-To: <E14krU0-0002P8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Problem: Linux kernel 2.4 consistently hangs at boot on 486 machine
> >
> > Shortly after lilo starts the kernel it hangs at the following message:
> > Checking if this processor honours the WP bit even in supervisor mode...
> > <blinking cursor>
> 
> Does this happen on 2.4.3-ac kernel trees ? I thought i had it zapped
> 

Yes, that fix in -ac should take care of it.  As to why only the 486
showed the problem, most 386's will not fault on the write protected
page (the whole reason for this test) and pentiums and later don't run
the test at all (assumed good).

--

				Brian Gerst
