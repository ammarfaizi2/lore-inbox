Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUFDOZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUFDOZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 10:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbUFDOZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 10:25:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:64963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265789AbUFDOZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 10:25:23 -0400
X-Authenticated: #21910825
Message-ID: <40C0863E.9070508@gmx.net>
Date: Fri, 04 Jun 2004 16:25:02 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: smolny@o2.pl
CC: foner+x-forcedeth@media.mit.edu, Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew de Quincey <adq@lidskialf.net>, Netdev <netdev@oss.sgi.com>
Subject: Re: Forcedeth and vesa
References: <20040604135640.C218BD0B60@rekin6.o2.pl>
In-Reply-To: <20040604135640.C218BD0B60@rekin6.o2.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[foner: I included you in the CC because your problem seems similar.]

smolny@o2.pl wrote:
> Hi,
> Sorry if you get this post by mistake. I found your address googling
> for "forcedeth vesa".

Well, you reached the right person.

> When i use forcedeth module, both with 2.4.26 and 2.6.6 kernels, i
> can't access vesa with mplayer. Just loading the module doesn't
> cause the problem, only after i configure the net with ifconfig i
> can't use vesa.

This is interesting. Does the problem persist if you ifdown the interface?

> If i use nvnet NVidia driver with 2.4.26, everything goes fine (no
> nvnet for 2.6.x kernels). 

That is even more interesting. So the bug affects forcedeth, but not
nvnet. Hmmm. We'll have to review the code again.

> It's an EPOX 8RDA+ motherboard.

Foner: Do you see similarities between your problem and this one?

Janusz, Foner: Are you willing to test forcedeth with a few dozen
iterations of
patch, recompile, install, power down, power up and test again?

I would send you patches to binary search the offending code.

Regards,
Carl-Daniel
