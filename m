Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbUAOX0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUAOX0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:26:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:2497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265216AbUAOX0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:26:45 -0500
Date: Thu, 15 Jan 2004 15:23:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm2
Message-Id: <20040115152306.2c56d6e3.rddunlap@osdl.org>
In-Reply-To: <4004458C.5040000@gmx.de>
References: <20040110014542.2acdb968.akpm@osdl.org>
	<4003F34E.5080508@gmx.de>
	<20040113095428.440762f7.akpm@osdl.org>
	<400441BD.9020609@gmx.de>
	<20040113111639.60b681d2.akpm@osdl.org>
	<4004458C.5040000@gmx.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 20:22:52 +0100 "Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:

| Andrew Morton wrote:
| > "Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
| > 
| >>>>kernel: Badness in pci_find_subsys at drivers/pci/search.c:132
| >>>>
| >>>>Any ideas? Or do you need detailed kernel config and dmesg? I thought 
| >>>>you might have an idea which atch caused this... My and his system are 
| >>>>quite differnt. Major Common element seems only use of Athlon XP. He has 
| >>>>VIA KT based system and I have nforce2. I thought it might be APIC, but 
| >>>>I also got a lock up without APIC. (Though it seems more stable without 
| >>>>APIC.)
| >>>
| >>>
| >>>If you could send us the stack backtrace that would help.  Make sure that
| >>>you have CONFIG_KALLSYMS enabled.  If you have to type it by hand, just the
| >>>symbol names will suffice - leave out the hex numbers.
| >>
| >>Sorry, I am a noob about such things. Above option is enabled in my 
| >>config, but I dunno how get the stack backtrace. Could you point to me 
| >>to something helpful?
| > 
| > 
| > When the kernel prints that `badness' message it then prints a stack
| > backtrace.  That's what we want.
| 
| But how to get that? When the machine locks up, I don't see anything 
| written and only *sometimes* I got above message in the log  -whcih I 
| can only see afterwards. But there is nothing else realted to it in the 
| log...

(I didn't see any replies to this...)

The usual answer is to use a serial console to log the kernel messages,
but not everyone has that option available to them.

Depending on your system, you might be able to use kmsgdump to
capture the final kernel messages to a floppy disk (if you have a
"legacy" type floppy).  If you are interested in trying that,
the kmsgdump patch is available at
  http://developer.osdl.org/rddunlap/kmsgdump/

--
~Randy
Everything is relative.
