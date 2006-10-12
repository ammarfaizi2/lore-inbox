Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWJLMVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWJLMVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWJLMVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:21:30 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:4323 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750935AbWJLMV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:21:29 -0400
Message-ID: <452E327C.9020707@aitel.hist.no>
Date: Thu, 12 Oct 2006 14:18:04 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1 - locks when using "dd bs=1M" from card reader
References: <20061010000928.9d2d519a.akpm@osdl.org>
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found an easy way to hang the kernel when copying a SD-card:

dd if=/dev/sdc of=file bs=1048576

I.e. copy the entire 256MB card in 1MB chunks.  I got about
160MB before the kernel hung.  Not even sysrq+B worked, I needed
the reset button.  The pc has a total of 512MB memory if that matters.

Using bs=4096 instead let me copy the entire card with no problems,
but that seems to progress slower.

The above 'dd' command hangs my office pc every time. So I can repeat
it for debugging purposes. 


Helge Hafting
