Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132399AbRDWJjK>; Mon, 23 Apr 2001 05:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDWJjA>; Mon, 23 Apr 2001 05:39:00 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:38058 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131986AbRDWJin>; Mon, 23 Apr 2001 05:38:43 -0400
Date: Mon, 23 Apr 2001 11:38:41 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: disable_ide_dma gcc-3.0 warn
Message-ID: <20010423113841.Q682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010423110753.A25081@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010423110753.A25081@werewolf.able.es>; from jamagallon@able.es on Mon, Apr 23, 2001 at 11:07:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 11:07:53AM +0200, J . A . Magallon wrote:
> In dmi_scan.c there is the func:
> static __init int disable_ide_dma(struct dmi_blacklist *d)
> 
> But now it is unused (intentionally ?):
> 
> static __initdata struct dmi_blacklist dmi_blacklist[]={
> #if 0    <==================
>     { disable_ide_dma, "KT7", { /* Overbroad right now - kill DMA on problem KT7
> boards */
>             MATCH(DMI_PRODUCT_NAME, "KT7-RAID"),
>             NO_MATCH, NO_MATCH, NO_MATCH
>             } },
> #endif  

I guess this is a leftover from the VIA buggy southbridge workaround hunt.

Code marked with "#if 0" and "#if 1" is usally under
development and subject to changes. 

Or left intentionally in "#if 0" to show the reader that we had
an wrong idea once, which seemed to be obviously correct (may be
from the docs) and we solved it with a different method, which is
not obvious or even not stated in the docs, but is the right one.

So we avoid stupid patches by leaving such things for reference.

In short: Don't care about new dead code too much, if it will be
   needed by a "#if 0" marked code section.

BTW: Which revision of gcc 3.0 do you use? I had no luck compiling
   it yet. Please answer in private to gcc issues.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
