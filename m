Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUJPQEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUJPQEA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 12:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUJPQD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 12:03:59 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:38386 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268771AbUJPQDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 12:03:49 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, nhorman@redhat.com, hancockr@shaw.ca
X-Message-Flag: Warning: May contain useful information
References: <416FCD3E.8010605@drzeus.cx> <41713B79.3080406@drzeus.cx>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 16 Oct 2004 09:03:44 -0700
In-Reply-To: <41713B79.3080406@drzeus.cx> (Pierre Ossman's message of "Sat,
 16 Oct 2004 17:17:13 +0200")
Message-ID: <52brf2bqfz.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Tasklet usage?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 16 Oct 2004 16:03:44.0504 (UTC) FILETIME=[B66AD780:01C4B399]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Pierre> As I was digging through the functions there was one thing
    Pierre> that struck me. The parameter for the tasklet is of type
    Pierre> unsigned long, not void*. Since the parameter in most
    Pierre> cases is a pointer this might cause problems on 64-bit
    Pierre> systems. Or does the kernel do some magic to map kernel
    Pierre> memory in the first 4 GB?

unsigned long will be 64 bits on a 64-bit system.  There are many
places in the Linux kernel where we assume that void * and long are
the same size.

 - Roland
