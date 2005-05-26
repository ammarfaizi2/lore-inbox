Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVEZJxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVEZJxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 05:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVEZJxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 05:53:09 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:5619 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S261289AbVEZJxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 05:53:03 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: akpm@osdl.org
Subject: Re: [linux-pm] potential pitfall? changing configuration while PC in hibernate (fwd)
Date: Thu, 26 May 2005 11:52:33 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261152.34616.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler <cijoml@volny.cz> wrote:
>
> It is real stupid, that Linux kernel freezes when simply during hibernate I
> change Bluetooth dongle to USB mouse in my USB port.
>
> And it is not uncommon problem - I have BT dongle that starts in HID proxy
> mode and then I switch it to HCI mode. So I hibernate with BT dongle and
> after hibernate Linux only reads image from Swap and then freezes! :
( Problem
> is, that It delete image from swap imeditially after reading it, so when I
> tried is simply with USB mouse (hibernate without it and plug it when
> notebook was switched off) it doesn't read it from swap ever and I lost all
> my memory :(
>
> I can do nothing with this behavior of my dongle and there is no known way 
how
> to switch it back to HID-proxy mode before hibernate (Marcel correct me if I
> am wrong) - CSR based dongle D-Link with Apple firmware.
>
> Windows knows it and doesn't have problem with it for 5 years! :)
>
> Laptop is all Intel based, kernel 2.6.11.5-vanilla, gcc 3.4.3, Debian 
testing

Can you please retest 2.6.12-rc5, see if this bug is still there?

Thanks.
----------------------------
Hi Andrew,

partial success:

when changing mouse resume from hibernation works

when hibernate with BT dongle in HCI mode and then starts with it (allways 
starts in HIDproxy mode acting as USB mouse and keyboard) kernel still 
freezes after reading 100% of memory from swap.
After reset kernel doesn't attempts to read memory from swap again and so 
memory is lost :(

Other problem is that after hibernate GL application never works anymore
testet x.org with i915 module and xfree-4.3.0 with i830 module:

cijoml@notas:~$ > glxgears
intelWaitIrq: drmI830IrqWait: -16

Michal
-- 
