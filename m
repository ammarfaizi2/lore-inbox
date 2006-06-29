Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWF2RlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWF2RlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWF2RlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:41:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751098AbWF2RlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:41:22 -0400
Date: Thu, 29 Jun 2006 10:41:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm one process gets stuck in infinite loop in the
 kernel.
Message-Id: <20060629104117.e96df3da.akpm@osdl.org>
In-Reply-To: <44A3B8A0.4070601@aitel.hist.no>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<44A3B8A0.4070601@aitel.hist.no>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 13:25:20 +0200
Helge Hafting <helge.hafting@aitel.hist.no> wrote:

> I have seen this both with mm2, m33 and mm4.
> Suddenly, the load meter jumps.
> Using ps & top, I see one process using 100% cpu.
> This is always a process that was exiting, this tend to happen
> when I close applications, or doing debian upgrades which
> runs lots of short-lived processes.
> 
> I believe it is running in the kernel, ps lists it with stat "RN"
> and it cannot be killed, not even with kill -9 from root.
> 
> Something wrong with process termination?
> 

Please generate a kernel profile when it happens so we can see
where it got stuck.

<boot with profile=1>
<wait for it to happen>
readprofile -r
sleep 10
readprofile -n -v -m /boot/System.map | sort -n -k 3 | tail -40
