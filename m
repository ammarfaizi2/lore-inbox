Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264992AbUGGIh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbUGGIh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUGGIh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:37:27 -0400
Received: from quechua.inka.de ([193.197.184.2]:55218 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264992AbUGGIaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:30:22 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum) que stio n
Organization: Deban GNU/Linux Homesite
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FD7@whq-msgusr-02.pit.comms.marconi.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1Bi7or-0001e9-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 07 Jul 2004 10:30:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <313680C9A886D511A06000204840E1CF08F42FD7@whq-msgusr-02.pit.comms.marconi.com> you wrote:
> So I think that above is anwering my original question, that in the "worst
> case" scenario - unless the rescheduling is induced earlier by explicit or
> implicit (via certain system calls) invokation of the schedule() function
> call, - the attempt of rescheduling (again, of course, by calling schedule()
> function call) will be done at least at every "clock tick time" (say every
> 10 ms, which is default value)  ?

Only if the interrupts are not disabled, which can happen if another
interrupt handlers bottom half takes too long. And then you still have the
critical sections in kernel, or the big kernel lock which may block the next
syscall.

Gruss
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
