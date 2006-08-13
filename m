Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWHMSCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWHMSCh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 14:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWHMSCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 14:02:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:27088 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751351AbWHMSCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 14:02:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DKKNFtFmUUQpHNGEOUwvsIf4Rvcu5YRPgwsTQhYo2182pgM2RZ6M9w2qwh0G1w4rT2a2spXwsG0fa9+ZL5NTaz27BlSfygE+O/8tZd1LuKMSMfNpkkArzbIDdre2sGu02DMoG4o8bqZITo8nmc4LksninE+Ohj1reUTc32W/cns=
Message-ID: <6b4360c80608131102g5fa30b21gfc9b2f83996a1f63@mail.gmail.com>
Date: Sun, 13 Aug 2006 13:02:34 -0500
From: "Nick Manley" <darkhack@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: IRQ Issues with 2.6.17.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155489057.24077.152.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4360c80608130836t1169daf2vd5bc6a0a373989e8@mail.gmail.com>
	 <1155489057.24077.152.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not a kernel hacker so I don't know a whole lot about it but I
figured that these errors would be the cause of ndiswrapper not
working correctly since they appear even without it installed and not
to mention the odd behavior that occurs.  Depending on exactly which
distro or kernel that I am using, sometimes ndiswrapper will cause a
kernel panic and other times I can load the driver but no new network
interface would appear.  I suspected that the culprit would be that
the kernel isn't properly assigned my wireless card an IRQ.

>From versions 2.6.11 through 2.6.15.x my system would not boot at all
unless I passed some kind of parameter (like irqpoll or acpi=off) and
it wasn't until 2.6.16 that this was fixed.  My line of thinking was
that maybe the problem still existed and that my USB wireless card
(SMC2862-W) was not being recognized.

I'm not a master of kernel messages but a few of the messages such as
the "mp-bios bug" and "cannot allocate region 3 of device" which
appeared during the boot process of several distros made me worry.

I'll report this to the ndiswrapper developers.  I'm sorry if I took
up your time.  I really appreciate your efforts.  Thank you for all of
your help.

On 8/13/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> Looking at the trace I see only a couple of things and neither look like
> problems with the kernel
>
> - your distribution seems to be loading the wrong driver for the network
> card (8139cp not 8139too). Take that up with the distro provider I
> suspect or check your config has the right drivers included
>
> - The BIOS timer setup is a bit odd in the BIOS. From dmesg we select
> the timer via virtual wire mode and sort that out
>
> and the "Cannot allocate resource" one looks harmless too.
>
>
>
> So what actual problems are you really seeing (other than the expected
> 'NDISwrapper doesn't work')
>
>
