Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264596AbUEaEMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbUEaEMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 00:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUEaEMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 00:12:19 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:13654 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264609AbUEaELm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 00:11:42 -0400
Date: Sun, 30 May 2004 22:11:40 -0600 (MDT)
From: Stephen Smoogen <smoogen@lanl.gov>
To: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
In-Reply-To: <200405310152.i4V1qNk03732@mailout.despammed.com>
Message-ID: <Pine.LNX.4.58.0405302207450.19352@smoogen3.lanl.gov>
References: <200405310152.i4V1qNk03732@mailout.despammed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004 ndiamond@despammed.com wrote:

>A driver, implemented as a module, must do some floating-point
>computations including trig functions.  Fortunately the architecture is
>x86.  A few hundred kilograms of searching (almost a ton of searching
>:-) seems to reveal the following possibilities.

How much precision do you need for you hardware device? It would
probably be easier to use 1 to 2 precision point old integer approx
equations for what you are wanting. However, it is probably the worst
thing to do by putting that much overhead into kernel space. In the end,
if you are needing tight control anyway, a real time kernel would be a 
better match for your requirements. Keep the hardware as simple as 
possible (or put the calculations into the sub-hardware piece).


-- 
Stephen John Smoogen		smoogen@lanl.gov
Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
-- You should consider any operational computer to be a security problem --
