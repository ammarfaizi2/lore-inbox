Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276829AbRJCBTH>; Tue, 2 Oct 2001 21:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276830AbRJCBS4>; Tue, 2 Oct 2001 21:18:56 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:60707 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276829AbRJCBSm>; Tue, 2 Oct 2001 21:18:42 -0400
Subject: Re: 2.4.10/Preemt STOP bug
From: Robert Love <rml@tech9.net>
To: Justin A <justin@bouncybouncy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011002205856.A19554@bouncybouncy.net>
In-Reply-To: <20011002205856.A19554@bouncybouncy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 02 Oct 2001 21:19:07 -0400
Message-Id: <1002071952.864.141.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-02 at 20:58, Justin A wrote:
> It seems there is a bug in 2.4.10 or the preemptable patch that causes the STOP
> signal to not work right 19 times out of 20 or so.
>
> This is most easily seen by running 'seq 1 100000' in a terminal and pressing
> control Z or using kill -STOP the proccess stops, but the parent process never
> comes back, kill -CONT has to be used in order to get the proccess back.
> 
> CPU usage my be a factor in this, yes(1) backgrounds correctly more often then
> seq does.
> 
> There are no problems with fg/CONT.

The problem is with the preemptible kernel patch...

You need to be using a recent patch, this bug was fixed awhile back in
an explicit patch (patch-rml-2.4.xx-preempt-ptrace-signal-fix-1).

It was merged into the 2.4.10 patch with revision 5, and it is in all
newer patches.

You can get patches for 2.4.10, 2.4.11-pre2, and 2.4.10-ac3 (soon -ac4)
at http://tech9.net/rml/linux

They all fix this problem.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

