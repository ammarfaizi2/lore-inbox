Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264974AbSJ3XrC>; Wed, 30 Oct 2002 18:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264973AbSJ3Xq6>; Wed, 30 Oct 2002 18:46:58 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:48770 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S264972AbSJ3Xqz>; Wed, 30 Oct 2002 18:46:55 -0500
Message-Id: <200210310050.g9V0ob5e001389@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 30 Oct 2002 19:50:36 -0500
From: Skip Ford <skip.ford@verizon.net>
To: root <root@oddball-en.prodigy.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.44-mm6 issues - CORRECTED REPOST
References: <Pine.LNX.4.44.0210301830500.1451-100000@oddball.prodigy.com> <Pine.LNX.4.44.0210301840560.1583-100000@oddball.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210301840560.1583-100000@oddball.prodigy.com>; from root@oddball-en.prodigy.com on Wed, Oct 30, 2002 at 06:44:00PM -0500
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Wed, 30 Oct 2002 17:53:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root wrote:
> On Wed, 30 Oct 2002, Bill Davidsen wrote:
> 
> > Trying to compile with netfilter enabled:
> 
> At this point the include directive pulled a random dump or something, the 
> following is the correct compile error. This mailer is NOT configured.!
> 
> net/ipv4/tcp_diag.c
>   gcc -Wp,-MD,net/ipv4/.raw.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=raw   -c -o net/ipv4/raw.o net/ipv4/raw.c
> net/ipv4/raw.c: In function `raw_send_hdrinc':
> net/ipv4/raw.c:297: `NF_IP_LOCAL_OUT' undeclared (first use in this function)
> net/ipv4/raw.c:297: (Each undeclared identifier is reported only once
> net/ipv4/raw.c:297: for each function it appears in.)
> make[2]: *** [net/ipv4/raw.o] Error 1
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2

This patch solves that.
http://www.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/cset-1.793.6.1.txt

-- 
Skip
