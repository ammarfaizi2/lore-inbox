Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWHWCIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWHWCIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 22:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWHWCIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 22:08:45 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:4541 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932245AbWHWCIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 22:08:45 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org, mtosatti@redhat.com,
       "Patrick J. Volkerding" <volkerdi@slackware.com>
Subject: Re: Linux 2.4.33.2
Date: Wed, 23 Aug 2006 12:08:41 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <jvdne21bml6hjs02iha801gc8g777vjh1s@4ax.com>
References: <20060822212300.GA30360@hera.kernel.org>
In-Reply-To: <20060822212300.GA30360@hera.kernel.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 21:23:00 +0000, Willy Tarreau <wtarreau@hera.kernel.org> wrote:

>
>Hi !
>
>Linux 2.4.33.2 is out. It fixes a local privilege escalation in SCTP
>(CVE-2006-3745). Also included are a fix for a bad address check in
>binfmt_elf (already in 2.6), and a fix for build on some non-sparc
>architectures which I broke in 2.4.33.1 when trying to fix the memchr()
>export (problem reported by Mikael Pettersson).
>
>If does not contain the UDF fix which went in 2.6.17.10. I will check
>whether it applies to 2.4 and will backport it for a future release.
>
>### Important note for users of Slackware 10.2 ###
>
>Grant Coady informed me that 2.4.33.1 did not boot for him. After a long
>series of tests from him and Pat Volkerding, it appeared that the problem
>is caused by glibc 2.3.6 wrongly detecting kernel version as 4.33.1 and
>mistakenly using the NTPL libs instead.
>
>Patrick has fixed the problem and will (has ?) send the fix to the glibc
>team. By now people using Slackware 10.2 must upgrade their glibc to
>glibc-solibs-2.3.5-i486-6_slack10.2.tgz if they want to run a 2.4.33.x
>kernel (user glibc-2.3.6 build -5 for -current). A workaround is either
>to rename /lib/tls or to rename the kernel to something different than
>4 numbers separated by dots. Since the problem is fixed, I don't intend
>to change the numbering.
>
>I dont think that this problem might affect many other distros since those
>shipping an NPTL-enabled libc with both 2.4 and 2.6 mainline are rare. If
>anyone else encounters the problem, Pat has the fix.

Okay here ;)

<http://bugsplatter.mine.nu/test/linux-2.4/>

+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
| kernel version  |deltree|hal    |niner  |peetoo |pooh   |sempro |silly  |tosh   |
+ - - - - - - - - + - - - + - - - + - - - + - - - + - - - + - - - + - - - + - - - +
| 2.4.33.2 [2]    |   -   |   Y   |   Y   |   Y   |       |   Y   |   Y   |   Y   |
| 2.4.33-2 [1]    |   Y   |   Y   |   Y   |   Y   |       |   Y   |   Y   |   Y   |
| 2.4.33-1 [1]    |   Y   |   Y   |   Y   |   Y   |       |   Y   |   Y   |   Y   |
| 2.4.33-final    |   Y   |   Y   |   Y   |   Y   |       |   Y   |   Y   |   Y   |
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
[1] unofficial rename of 2.4.33.1 for testing under slackware, to be resolved...
[2] requires upgrade to glibc-solibs-2.3.5-i486-6_slack10.2.tgz for slack-10.2


Box deltree is halfway from slack-10.2 to slack-current, therefore not tested.

Cheers,
Grant.
