Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318273AbSGRQuS>; Thu, 18 Jul 2002 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318271AbSGRQuS>; Thu, 18 Jul 2002 12:50:18 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:57551 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S318278AbSGRQt0>; Thu, 18 Jul 2002 12:49:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: zhengchuanbo <zhengcb@netpower.com.cn>
Subject: Re: Re: problem of linux-2.4.19
Date: Thu, 18 Jul 2002 18:57:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1020718100527.16097A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020718100527.16097A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020718165014Z318278-685+12831@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 16:18, Richard B. Johnson wrote:
> On Thu, 18 Jul 2002, zhengchuanbo wrote:
> > i   replaced 'read-only' in lilo with 'read-write'. and it worked.
>
> No!  The file-system must be mounted read-only upon startup! There
> are exceptions in embedded systems and special systems that build
> file-systems (root file-system ram-disks) upon startup.

True.
in my previous mail i forgot to mention that it is not recommended to mount 
root read-write on startup...

> The init scripts should check the file-systems (using fsck) and
> then mount them read-write. If you (or init) executes fsck
> on r/w mounted file-systems, you may (read will) destroy them.
> Look in /etc/rc.d to see what happens upon startup. Something
> like `fsck -A -V -a` gets executed. Then, after than happens,
> something like `mount -n -o remount,rw /` gets executed. Then,
> to update /etc/mtab, somewhere there will be a `mount -f /`.

you really should check if this gets executed in one of your bootscripts and 
otherwise change them to do it this way.

	Rudmer
