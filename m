Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUEWXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUEWXlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 19:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUEWXlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 19:41:24 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:55468 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263745AbUEWXlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 19:41:22 -0400
Date: Mon, 24 May 2004 01:39:30 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioctl number 0xF3
Message-ID: <20040524013930.A21374@electric-eye.fr.zoreil.com>
References: <40AF42B3.8060107@winischhofer.net> <1085228451.14486.0.camel@laptop.fenrus.com> <40AF4A13.4020005@winischhofer.net> <20040522125108.GB4589@devserv.devel.redhat.com> <40AF55AF.2020506@winischhofer.net> <20040522163214.A32228@electric-eye.fr.zoreil.com> <40AF73D5.5010202@winischhofer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40AF73D5.5010202@winischhofer.net>; from thomas@winischhofer.net on Sat, May 22, 2004 at 05:37:57PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Winischhofer <thomas@winischhofer.net> :
[...]
> The interface I intend to use matches the one the X driver has (using 
> the Xv extension as an ioctl replacement) and will be documented. Since 
> I develope both the SiS kernel framebuffer driver as well as the SiS X 
> driver this will reduce duplicate code and ensures good cooperation. 
> Furthermore, there could be a common library for both the framebuffer and X.

As you apparently manage the utility, you are at the first place to handle
the incompatibilities as well. Fine :o)

> Hm. Were the matrox folks asked for a "clear interface" in advance when 
> they started using the 'n' ioctls? Am I too polite? ;)

Nonononono. It is just a bit optimistic to hope for an instant solution
here if there has not been one so far on the xfree/friends side. Imo
there are some grey areas:
- what does the common part need;
- who can/want/will do the dirty work.
Looking at the code, there is no instant answer and things won't be set
in stone today. The best you can do is to minimize the pain in the future:
use as few ioctls as possible so that you can control/verify the changes
of interface trough a single point and design this interface so that it
takes into account that things will change. No silver bullet.

[...]
> sisfb uses a few ioctls already, as an extension to the generic fb 
> related ioctls. (Although the version currently in mainline 2.4 is not 
> in any way 32/64 bit safe, and neiter is the mainline 2.6 version yet as 
> regards the obviously required ioctl32 emulation stuff - investigating 
> this at the moment).

Consider reusing these ? It may be a bit academic as you control the main
utility anyway.

--
Ueimor
