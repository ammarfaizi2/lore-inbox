Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTINX4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 19:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTINX4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 19:56:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37645 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262409AbTINX4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 19:56:14 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: 14 Sep 2003 23:47:13 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bk2um1$flp$1@gatekeeper.tmr.com>
References: <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com> <20030912195606.24e73086.ak@suse.de>
X-Trace: gatekeeper.tmr.com 1063583233 16057 192.168.12.62 (14 Sep 2003 23:47:13 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030912195606.24e73086.ak@suse.de>,
Andi Kleen  <ak@suse.de> wrote:
| On 12 Sep 2003 11:32:42 -0600
| ebiederm@xmission.com (Eric W. Biederman) wrote:
| 
| 
| > There may be better places to attack.  But new code is what is up for
| > examination and is easiest to fix.
| 
| With is_prefetch:
| 
|    text    data     bss     dec     hex filename
|    2782       4       0    2786     ae2 arch/i386/mm/fault.o
| 
| Without is_prefetch:
| 
|  text    data     bss     dec     hex filename
|    2446       4       0    2450     992 arch/i386/mm/fault.o
| 
| Difference 332 bytes
| 
| If you start your attack on 332 bytes then IMHO you have your priorities wrong ;-)
| 
| The main reason I'm really against this is that currently the P4 kernels work
| fine on Athlon. Just when is_prefetch is not integrated in them there will 
| be an mysterious oops once every three months in the kernel in prefetch
| on Athlon.
|  
| That would be bad. The alternative would be to prevent the P4 kernel
| from booting on the Athlon at all, but doing that for 332 bytes
| would seem a bit silly.

I am really missing something here, why is it you want to run a P4
kernel on Athlon? And why is it good to push bloat into the kernel and
then tell people who really care about size to go peddle their papers
elsewhere? There is perfectly good code in the kernel now to disable
prefetch on Athlon, leave it in unless the kernel is built for Athlon
support. A P4 kernel should run fine on an Athlon already.

We just got a start on making Linux smaller to encourage embedded use, I
don't see adding 300+ bytes of wasted code so people can run
misconfigured kernels.

I rather have to patch this in for my Athlon kernels than have people
who aren't cutting corners trying to avoid building matching kernels
have to live with the overhead.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
