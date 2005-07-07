Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVGGBVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVGGBVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 21:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVGGBTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 21:19:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262343AbVGGBRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 21:17:04 -0400
Date: Wed, 6 Jul 2005 18:16:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: P@draigBrady.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: How do you accurately determine a process' RAM usage?
Message-Id: <20050706181623.3729d208.akpm@osdl.org>
In-Reply-To: <42CC2923.2030709@draigBrady.com>
References: <42CC2923.2030709@draigBrady.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P@draigBrady.com wrote:
>
> I wrote a tool to report how much RAM a
>  particular program (apache for e.g.) was using:
>  http://www.pixelbeat.org/scripts/ps_mem.py
> 
>  I was then pointed at the following:
>  http://wiki.apache.org/spamassassin/TopSharedMemoryBug
>  which describes how copy-on-write pages are
>  not counted as shared since 2.6.
> 
>  So how can one determine how much RAM a process is using?
>  Seems like a fundamental requirement to me.
>  Could we add a "SharedTotal" column to /proc/$$/statm for e.g. ?

Calculating this stuff accurately is very expensive.  You'll get a better
answer using proc-pid-smaps.patch from -mm, but even that won't tell you
things about sharing levels of the pages.

