Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUBYNGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUBYNGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:06:08 -0500
Received: from intra.cyclades.com ([64.186.161.6]:26837 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261312AbUBYNF7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:05:59 -0500
Date: Wed, 25 Feb 2004 11:01:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mika =?ISO-8859-1?Q?=20Bostr=F6m?= <bostik@lut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another case of lockup using combination of devices (sound+net)
In-Reply-To: <20040224172310.GA6083@odin.lnet.lut.fi>
Message-ID: <Pine.LNX.4.58L.0402251052210.21511@logos.cnet>
References: <20040224172310.GA6083@odin.lnet.lut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Feb 2004, Mika   Boström wrote:

>   I hope this bug report has all the required bits in it, I haven't done
> this before. I tried to follow the instructions and included some
> additional information usually seen here (.config, dmesg). On with the
> bug report...
>
>
> [1.] Complete hang when using sound and network simultaneously (2.6.x)
>
> [2.] I noticed that another person has had similar problems:
> http://marc.theaimsgroup.com/?t=107699689400003&r=1&w=2
> While listening to music (xmms, ALSA output) I have had complete
> lockups. There is no indication of a problem, and nothing ever gets
> written to logs. When the system locks up, even keyboard goes
> unresponsive: capslock, numlock, scroll-lock don't flash lights, magic
> key does not register. Before the posting above I couldn't find any
> reason, but my latest lockup happened while listening to music pulling
> data in at a rate of about 6.5 MB/s. The transfer had lasted for perhaps
> 10 seconds before system hung.
>
> This has occurred with all the 2.6 kernels I have tried: 2.6.0-test8,
> 2.6.1, and now 2.6.3. Looking at the thread above I took notice that I
> had previously had an enormous amount of interrupt errors (~120k/day).
> Disabling IO-APIC from kernel configuration apparently solved that, now
> they occur approximately 1 error/day. No difference there, the lockup
> still takes place. ACPI has never been enabled. Sound card is C-Media
> 8738 based Trust, NIC is a 3com 905B. ATI's proprietary kernel module
> has not been loaded at any of these instances. (It broke all kinds of
> things on its own.)

Radeon and the 3com are sharing interrupt 11.

That can cause problems. Try changing the interrupt of one of the cards.

