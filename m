Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264940AbUEQIuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbUEQIuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 04:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUEQIuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 04:50:09 -0400
Received: from zork.zork.net ([64.81.246.102]:14809 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264940AbUEQIuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 04:50:01 -0400
To: Andi Kleen <ak@suse.de>
Cc: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
References: <20040513032736.40651f8e.akpm@osdl.org>
	<6usme4v66s.fsf@zork.zork.net> <20040513135308.GA2622@redhat.com>
	<20040513155841.6022e7b0.ak@suse.de> <6ulljwtoge.fsf@zork.zork.net>
	<20040513174110.5b397d84.ak@suse.de> <6u8yfvsbd4.fsf@zork.zork.net>
	<6uk6zeow52.fsf@zork.zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, davej@redhat.com,  akpm@osdl.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 17 May 2004 09:49:56 +0100
In-Reply-To: <6uk6zeow52.fsf@zork.zork.net> (Sean Neakums's message of "Sat,
 15 May 2004 10:52:09 +0100")
Message-ID: <6u65avmo97.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> Sean Neakums <sneakums@zork.net> writes:
>
>> Andi Kleen <ak@suse.de> writes:
>>
>>> Sean, can you double check that when you compile the AGP driver as module
>>> that the 7124 PCI ID appears in modinfo intel-agp ? 
>>> And does the module also refuse to load ? 
>>
>> I rebuilt with agpgart, intel-agp and i810 as modules, modprobed them,
>> and it works.
>
> I just realised that I probably forgot to reapply the patch before
> doing this test.  Will check Monday.  Sorry about this.

Below is modinfo output.  The module loads but doesn't initialise the
AGP.

  author:         Dave Jones <davej@codemonkey.org.uk>
  license:        GPL and additional rights
  vermagic:       2.6.6-mm2 preempt PENTIUMIII REGPARM 4KSTACKS gcc-3.4
  depends:        agpgart
  alias:          pci:v00008086d00007180sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00007190sv*sd*bc06sc00i00*
  alias:          pci:v00008086d000071A0sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00007120sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00007122sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00007124sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00001130sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00002500sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00002501sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00003575sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00001A21sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00001A30sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00002560sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00002530sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00003340sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00003580sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00002531sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00002570sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00002578sv*sd*bc06sc00i00*
  alias:          pci:v00008086d00002550sv*sd*bc06sc00i00*
  alias:          pci:v00008086d0000255Dsv*sd*bc06sc00i00*
