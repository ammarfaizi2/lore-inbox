Return-Path: <linux-kernel-owner+w=401wt.eu-S932812AbXAKW5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbXAKW5P (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 17:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbXAKW5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 17:57:15 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50585 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812AbXAKW5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 17:57:14 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Thu, 11 Jan 2007 23:57:06 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Linux-2.6.20-rc4 - Kernel panic!
To: Sunil Naidu <akula2.shark@gmail.com>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <8355959a0701111329t506ba4e6g993400ea31d47b3e@mail.gmail.com>
Message-ID: <tkrat.f1956029d478404e@s5r6.in-berlin.de>
References: <8355959a0701110300j33d28f54y67728eb847c7ba31@mail.gmail.com> 
 <45A681E5.6060502@s5r6.in-berlin.de> 
 <8355959a0701111211m416e202bx637bca22f8fca826@mail.gmail.com> 
 <tkrat.113437f9eecab84a@s5r6.in-berlin.de>
 <8355959a0701111329t506ba4e6g993400ea31d47b3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sunil Naidu wrote:
> I meant to ask choosing (from Xconfig tree)  a driver as module has
> same affect compare to compiling a driver as kernel builtin feature?
> (while loading/booting of kernel)

No, it hasn't quite the same effect:

>> Modules have to be loaded from a filesystem while built-in features are
>> available from the start.

...
> I did check the distro .config file (2.6.18-1.2868.fc6). Even I have
> changed the my .config files according to the distro's. Even after
> that, same error message.

Check if you also built the initrd the same way as the distributed one,
i.e. examine their contents. If it was, try booting an own kernel and
initrd built from FC6's 2.6.18-* sources. If that fails too, build a
kernel with all drivers compiled in which you know you need to access
the root FS. If that kernel still fails to mount the root FS, look for
any earlier error messages in the boot sequence.
-- 
Stefan Richter
-=====-=-=== ---= -=-==
http://arcgraph.de/sr/

