Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144481AbRA2Byi>; Sun, 28 Jan 2001 20:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144844AbRA2By2>; Sun, 28 Jan 2001 20:54:28 -0500
Received: from ir.com.au ([210.8.187.18]:9922 "EHLO ir_nt_server2.ir.com.au")
	by vger.kernel.org with ESMTP id <S144481AbRA2ByK>;
	Sun, 28 Jan 2001 20:54:10 -0500
Message-ID: <C0D2F5944500D411AD8A00104B31930E108096@ir_nt_server2>
From: Tony.Young@ir.com
To: slug@slug.org.au
Cc: csa@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Linux Disk Performance/File IO per process
Date: Mon, 29 Jan 2001 12:54:00 +1100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I work for a company that develops a systems and performance management
product for Unix (as well as PC and TANDEM) called PROGNOSIS. Currently we
support AIX, HP, Solaris, UnixWare, IRIX, and Linux.

I've hit a bit of a wall trying to expand the data provided by our Linux
solution - I can't seem to find anywhere that provides the metrics needed to
calculate disk busy in the kernel! This is a major piece of information that
any mission critical system administrator needs to successfully monitor
their systems.

I've looked in /proc - it provides I/O rates, but no time related
information (which is required to calculate busy%)
I've looked in the 2.4 kernel source
(drivers/block/ll_rw_blk.c,include/linux/kernel_stat.h - dk_drive* arrays) -
but can only see those /proc I/O rates being calculated.

Is this data provided somewhere that I haven't looked? Or does the kernel
really not provide the data necessary to calculate a busy rate?

I'm also interested in finding out file I/O metrics on a per process basis.
The CSA project run by SGI (http://oss.sgi.com/projects/csa) seems to
provide summarised I/O metrics per process using a loadable kernel module.
That is, it provides I/O rates for a process, but not for each file open by
that process.

Are there any existing methods to obtain this data? If so, can someone point
me in the right direction?
If not, what is the possibility of 'people-in-the-know' working towards
making these sort of metrics available from the kernel?
Could some of these metrics be added to the CSA project? (directed at the
CSA people of course.)

I'm more than willing to put in time to get these metrics into the kernel.
However, I'm new to kernel development, so it would take longer for me than
for someone who knows the code. But if none of the above questions can
really be answered I'd appreciate some direction as to where in the kernel
would be a good place to calculate/extract these metrics.

I believe that the lack of these metrics will make it difficult for Linux to
move into the mission critical server market. For this reason I'm keen to
see this information made available.

Thank you all for any help you may be able to provide.

I'm not actually subscribed to either the CSA or the linux-kernel mailing
lists, so I'd appreciate being CC'ed on any replies.
Thanks.

Tony...
--
Tony Young
Senior Software Engineer
Integrated Research Limited
Level 10, 168 Walker St
North Sydney NSW 2060, Australia
Ph: +61 2 9966 1066
Fax: +61 2 9966 1042
Mob: 0414 649942
tony.young@ir.com
www.ir.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
