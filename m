Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVAIQG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVAIQG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 11:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVAIQG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 11:06:58 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:47117 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261502AbVAIQGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 11:06:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ih871t20hIpnqE7PKKIYBbEDzPcc/XVlrCgUi7y9OgAcAVb9FSK4t8QwcnxNKfGt7AmZnGlikuYLSPYpLdilsHXmVYEdrGlSwF1Eis9UKeY0DV4pSZpWCbWdUIG4yoY7x5YmHOWxiWKZ1oNFXFI1BbS7ZrduEnL9kLeabSw6BZk=
Message-ID: <d91f4d0c050109080638cf0987@mail.gmail.com>
Date: Sun, 9 Jan 2005 11:06:54 -0500
From: George Georgalis <georgalis@gmail.com>
Reply-To: George Georgalis <georgalis@gmail.com>
To: linux-kernel@vger.kernel.org, michal@feix.cz
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
In-Reply-To: <20050109110805.GA8688@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E0F76D.7080805@feix.cz> <20050109110805.GA8688@irc.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005 12:08:05 +0100, Tomasz Torcz <zdzichu@irc.pl> wrote:
> On Sun, Jan 09, 2005 at 10:20:45AM +0100, Michal Feix wrote:
> > Hello evereyone!
> >
> > First, I'm not on kernel mailing list so please CC any replies to me.
> > Thank you.
> >
> > Yesterday I was recompiling my Linux from Scratch distribution for the
> > first time with Linux kernel 2.6.10 headers as a base for glibc. I've
> > found, that glibc (and XOrg later on too) won't compile, as there is a
> > conflict in certain functions or macros that glibc and Kernel headers
> > both define.
> 
>  Are you using proper kernel headers - from
> http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ ?


I with 2.6.10 a problem came up that had me looking into this too.

Using gcc 3.3.3, my xfree86 is built from cvs release xf-4_4-branch.
When I tried 2.6.10, it built with no problems.

To the best of my knolege, xfree86 is not including any kernel
headers, my source is not where any package would know to look and
there don't seem to be any distro (woody) kernel header packages
installed. I could be wrong, but I don't know where they might be
found, or that I ever needed them for this xfree86 build.

The problem is running X, my display is littered with flashing bits,
as if the card is rendering some cpu register or bus in 2% of the
display.

02:00.0 VGA compatible controller: nVidia Corporation: Unknown device
01f0 (rev a3) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Memory at e4000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

Is this due to namespace collision? Do I have to take extra
precautions with 2.6.10?

// George

-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
