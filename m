Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUD2W6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUD2W6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUD2W5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:57:40 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27660 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265034AbUD2W5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:57:12 -0400
Message-ID: <4091895A.6040800@techsource.com>
Date: Thu, 29 Apr 2004 19:01:46 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40911C01.80609@techsource.com> <20040429213246.GA15988@valve.mbsi.ca> <40917DBA.1080308@techsource.com> <6DB1DC9C-9A2B-11D8-B83D-000A95BCAC26@linuxant.com>
In-Reply-To: <6DB1DC9C-9A2B-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Boucher wrote:

> 
> The proprietary modem code for the HSF driver is not part of the kernel, 
> nor did its original developers ever intend for it to be run by the 
> Linux kernel.
> 
> Whether proprietary binary-only code is dynamically loaded through the 
> module subsystem or physically by someone installing a card is a 
> technicality with little relevance.


So, what you're saying is that you have taken a binary driver, not 
written by you, designed for an entirely different ABI, and you have 
written some code, which you have released under GPL, that interfaces 
between the Linux Kernel and the binary driver?

Kinda like that project which lets people use Windows network drivers 
under Linux?

I don't see a problem with that, ideologically.  I mean, it sucks that 
we can't get Linux-specific drivers, but at least people can use the 
hardware.


HOWEVER, there are two problems:

(1) It still taints the kernel, because the behavior of the Windows 
driver is still a black box that cannot be debugged.  The only way to 
avoid that would be to run the Windows driver in some kind of sandbox.

(2) Misleading the kernel (and users) into thinking that the driver does 
not taint the kernel, when in fact it does, is wrong.




You have pointed out an interesting point in another email.  I have to 
agree that, technically, thunking to BIOS code also taints the kernel, 
because it, too, is a black box which could corrupt the kernel.  What do 
others have to say about that?


