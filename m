Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTD3RPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTD3RPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:15:05 -0400
Received: from jk.sby.abo.fi ([130.232.136.104]:14852 "EHLO gemini.relay")
	by vger.kernel.org with ESMTP id S261328AbTD3RPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:15:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan Knutar <jk-lkml@sci.fi>
To: Elladan <elladan@eskimo.com>,
       James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Bug in linux kernel when playing DVDs.
Date: Wed, 30 Apr 2003 20:16:04 +0300
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, vda@port.imtp.ilyichevsk.odessa.ua,
       Nick Piggin <piggin@cyberone.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EABB532.5000101@superbug.demon.co.uk> <3EAFEA83.9030301@superbug.demon.co.uk> <20030430164641.GA8731@eskimo.com>
In-Reply-To: <20030430164641.GA8731@eskimo.com>
MIME-Version: 1.0
Message-Id: <03043020160401.29944@polaris>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The behavior most people seem to see here 90% of the time seems to be
> that the IDE layer retries the request a few dozen times before
> returning an error result.  This usually takes 1-5 minutes.
>
> So, does it return if you, say, go to lunch and then come back?

It's not just IDE. I have a machine with SCSI and an old 2X CDROM, 
which has troubble reading 80 min CD-R's, which I discovered doing a 
copy of a large file from it. Userspace locked up for a few days, and I 
don't just mean the cp process, I mean everything in userspace. The 
machine responded to pings and forwarded packets (It's my NAT machine), 
but not much else. Forced eject with pin clears it up in that case as 
well.

> Not to mention, blocking for 1-5 minutes even on a CD-ROM read is
> broken, and is certainly very unwanted for the task of playing a DVD.

It's unwanted for the task of anything, especially the 
everything-else-hangs-too behaviour that I observed, that might just be 
due to sim710 though ;-). (Kernel 2.4.18)
