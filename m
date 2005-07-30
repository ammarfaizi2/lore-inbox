Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVG3VzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVG3VzK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVG3VzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:55:09 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:49082 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261656AbVG3VzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:55:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: revert yenta free_irq on suspend
Date: Sun, 31 Jul 2005 00:00:09 +0200
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <200507302249.55409.rjw@sisk.pl> <Pine.LNX.4.61.0507302231280.4946@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0507302231280.4946@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507310000.10229.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 30 of July 2005 23:32, Hugh Dickins wrote:
> On Sat, 30 Jul 2005, Rafael J. Wysocki wrote:
> > 
> > Well, the patch is needed on other boxes too (eg. mine :-)) due to the recent
> > changes in ACPI.
> > 
> > Could you please send the /proc/interrupts from your box?
> 
>            CPU0       
>   0:    2818513          XT-PIC  timer
>   1:      56790          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   8:          2          XT-PIC  rtc
>  11:      57443          XT-PIC  yenta, yenta, eth0
>  12:     110579          XT-PIC  i8042
>  14:      31332          XT-PIC  ide0
>  15:     100988          XT-PIC  ide1
> NMI:          0 
> LOC:          0 
> ERR:          0
> MIS:          0

Thanks.  It looks like eth0 gets a yenta's interrupt and goes awry.
Could you please tell me what driver the eth0 is?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
