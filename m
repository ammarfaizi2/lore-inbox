Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbQLPMOM>; Sat, 16 Dec 2000 07:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131685AbQLPMOC>; Sat, 16 Dec 2000 07:14:02 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:61449 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130026AbQLPMNz>;
	Sat, 16 Dec 2000 07:13:55 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Lee Leahu <lee@ricis.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic: VFS: LRU block list corrupted 
In-Reply-To: Your message of "Sat, 16 Dec 2000 05:32:51 MDT."
             <5.0.0.25.2.20001216051043.00a6b008@mail.ricis.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Dec 2000 22:43:22 +1100
Message-ID: <15486.976967002@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000 05:32:51 -0600, 
Lee Leahu <lee@ricis.com> wrote:
>i'm not very familiar with klog, but i'll go with klogd.
>do i append a '-x' to the line that calls klogs in the startup scripts or
>is there some other better way of preventing klogd from destroying
>the Oops information.

Edit the script that starts klogd, probably /etc/rc.d/init.d/syslog.
Find the line that starts klogd, add '-x' to the options then restart
klogd (probably /etc/rc.d/init.d/syslog restart).

>Then i guess ksymoops. decodes the oops info

Absolutely.  See linux/Documentation/oops-tracing.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
