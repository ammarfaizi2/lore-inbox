Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265733AbUFOQBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265733AbUFOQBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUFOQBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:01:33 -0400
Received: from holomorphy.com ([207.189.100.168]:34983 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265724AbUFOQBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:01:24 -0400
Date: Tue, 15 Jun 2004 09:00:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Micah Anderson <micah@riseup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.6 grinds to a halt with moderate I/O
Message-ID: <20040615160049.GX1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Micah Anderson <micah@riseup.net>, linux-kernel@vger.kernel.org
References: <20040615154745.GD22650@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615154745.GD22650@riseup.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 10:47:45AM -0500, Micah Anderson wrote:
> Following the format from REPORTING-BUGS please see the below information.
> I unfortunately cannot subscribe to the list, but will follow the thread. I
> have searched high and low, read a number of threads somewhat tangential to
> this problem, and asked a few times in #kernelnewbies before I got to my
> wits end and now will try here. I really appreciate any insight anyone has,
> and will be happy to provide more information or additional tests
> 1. When doing moderate I/O on a 2.6.6 system the machine becomes unusable.
> 2. I found that with HIGHMEM support compiled into the kernel, when I
> did a cp -vr /var /usr/tmp it would work fine until it got about
> halfway through the large ldap.log file (approximately 500 megs) when
> the system would no longer be able to fork new processes. Your
> existing shell would function, but if you tried to run top, free, etc.
> it would hang. vmstat 1 would print the first line, but never
> continue. I ran a million different kernel configs to try and isolate
> things, and I thought I had it nailed down with passing apic=off to
> the kernel at boot because the large logfile copy test would
> pass, but when rsyncing maildirs tonight the same problem appeared. Early
> in my tests I thought the problem was dm-crypt, but the problem existed
> even when no encrypted filesystems were involved, and existed when I
> removed dm-crypt support from the kernel. Disabling HIGHMEM support seems
> to make the problem go away.

Thanks for the bugreport. I'm going to file this in the Debian BTS
after I get the FPU fixes out. Could you send along a dmesg
(/var/log/dmesg on Debian) and /proc/meminfo and /proc/cpuinfo at some
point when you can log into the box? I'll also try to reproduce this.

Thanks.


-- wli
