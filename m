Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261814AbSJNE3y>; Mon, 14 Oct 2002 00:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbSJNE3y>; Mon, 14 Oct 2002 00:29:54 -0400
Received: from mail1.panix.com ([166.84.1.72]:58836 "EHLO mail1.panix.com")
	by vger.kernel.org with ESMTP id <S261814AbSJNE3y>;
	Mon, 14 Oct 2002 00:29:54 -0400
Date: Sun, 13 Oct 2002 21:35:51 -0700
From: Jeff Lightfoot <jeffml@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: trond.myklebust@fys.uio.no, skraw@ithnet.com
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
Message-Id: <20021013213551.1ae7285a.jeffml@pobox.com>
In-Reply-To: <20021013172138.0e394d96.skraw@ithnet.com>
References: <20021013172138.0e394d96.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: Debian GNU/Linux 3.0;kernel 2.4.17
X-Face: 'u<#Qt^/)qW:&(>J[MA.~}578d+Wz3jc?f>yFwasPspU]Aq]z>~^7mt+~<Qi.>\+mlk.)8F LB,8#1B.a@vkU-P>GO7Jv'!a~5<!1TB{ba1P]/wSF+D2O.slxdmvp\6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> wrote:
 
> just to drop a note: I am experiencing a rather dramatic slowdown of
> the nfs-server in kernel 2.4.20-pre10 in conjunction with
> nfs-clients kernel 2.2.19. To be more specific, the server is a SMP
> machine and runs always the latest 2.4.x  kernels. Upto 2.4.20-pre9
> everything was quite ok, but pre10 brought an incredible loss. The
> setup did not change, only the kernel on the server side. Merely all
> nfs action is writing to the server, reading from it is next to zero
> in this setup.

I also had unexplained slowdown recently and after changing my
buffer sizes (rsize/wsize) back to 1024 (they have always been 8192),
speed increased 10x.

After banging my head for an hour or so this message was what made me
try the lower sizes.

http://www.geocrawler.com/archives/3/789/2002/8/0/9379245/

Even though the message states upgrading to 2.4.19 fixed it for him,
I'm using 2.4.19 on both machines and it looks like the problem still
persists.

Willing to give any info to those that care.

-- 
Jeff Lightfoot    --    jeffml@pobox.com    --    http://thefoots.com/
    "And I'm not done and I won't be till my head falls off. Though it
    may not be a long way off." -- TMBG
