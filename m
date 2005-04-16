Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVDPWqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVDPWqB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 18:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVDPWqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 18:46:01 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:10323 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261174AbVDPWpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 18:45:55 -0400
Message-ID: <42619599.8020008@tls.msk.ru>
Date: Sun, 17 Apr 2005 02:45:45 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coredump when program run as root?
References: <20050416181459.GB6681@charite.de>
In-Reply-To: <20050416181459.GB6681@charite.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt wrote:
> I found this while trying to find out why squid doesn't produce a core
> file:
> 
> http://lists.samba.org/archive/samba-technical/2002-August/023576.html
> 
> Most UNIX variants disable core dumps in programs that have changed their
> uid or euid during operation.  This includes Solaris and Linux.
> 
> Well, squid does exactly that. How can I still get a coredump? I really
> need one. Kernel 2.6.11.7

Not in stock kernel, no.
There's a patch in -ac series which implements 'suid_dumpable' attribute.
It is included with RedHat kernels I think.
The fun stuff is that I wasn't able to use the functionality anyway (i
had similar but a bit worse problem) -- regardless of how hard i tried,
it didn't produce any core dumps ;)

/mjt

P.S.  Hi, Ralf! The world is too small! ;)
