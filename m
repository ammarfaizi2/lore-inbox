Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbQKDBjY>; Fri, 3 Nov 2000 20:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132326AbQKDBjP>; Fri, 3 Nov 2000 20:39:15 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:27149 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132318AbQKDBjH>;
	Fri, 3 Nov 2000 20:39:07 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: James Simmons <jsimmons@suse.com>
cc: tytso@mit.edu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10) 
In-Reply-To: Your message of "Fri, 03 Nov 2000 17:10:52 -0800."
             <Pine.LNX.4.21.0011031700150.17266-100000@euclid.oak.suse.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 Nov 2000 12:38:58 +1100
Message-ID: <4871.973301938@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000 17:10:52 -0800 (PST), 
James Simmons <jsimmons@suse.com> wrote:
>
>>      * VGA Console can cause SMP deadlock when doing printk {CRITICAL}
>>        (Keith Owens)
>
>Still not fixed :-( Here is the patch again. Keith give it a try and tell
>me if it solves your problems.

The patch looks OK to me.  I worked around my original problem (screen
deadlock in kdb) by skipping the cli()/restore_flags() when kdb is
active, kdb guarantees that only one cpu at a time is doing any work.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
