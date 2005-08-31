Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVHaASv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVHaASv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHaASv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:18:51 -0400
Received: from mulnx11.mcs.muohio.edu ([134.53.6.66]:37774 "EHLO
	mulnx11.mcs.muohio.edu") by vger.kernel.org with ESMTP
	id S932301AbVHaASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:18:50 -0400
Message-ID: <4314F761.2050908@kundor.org>
Date: Tue, 30 Aug 2005 20:18:41 -0400
From: Nick Matteo <kundor@kundor.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050824)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MAX_ARG_PAGES has no effect?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other day I was running a grep on a big directory tree and got a 
"Argument list too long" error.  Since I'd like to have this work 
without messing with find and xargs each time, I went into 
include/linux/binfmts.h and changed

#define MAX_ARG_PAGES 32

to

#define MAX_ARG_PAGES 64

I recompiled and installed the kernel, but there's no change (getconf 
ARG_MAX still gives 131072.)  What am I missing?

I am running 2.6.13 on amd64.

Thanks,
Nick Matteo
