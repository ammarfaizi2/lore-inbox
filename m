Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932888AbWF2L3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888AbWF2L3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932895AbWF2L3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:29:18 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:57984 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932888AbWF2L3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:29:17 -0400
Message-ID: <44A3B8A0.4070601@aitel.hist.no>
Date: Thu, 29 Jun 2006 13:25:20 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm one process gets stuck in infinite loop in the kernel.
References: <20060629013643.4b47e8bd.akpm@osdl.org>
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen this both with mm2, m33 and mm4.
Suddenly, the load meter jumps.
Using ps & top, I see one process using 100% cpu.
This is always a process that was exiting, this tend to happen
when I close applications, or doing debian upgrades which
runs lots of short-lived processes.

I believe it is running in the kernel, ps lists it with stat "RN"
and it cannot be killed, not even with kill -9 from root.

Something wrong with process termination?



The machine is still useable, although with less power.
renicing the unkillable cpu hog seems to help.  I have not
yet seen more than one process end up like this.

Helge Hafting
