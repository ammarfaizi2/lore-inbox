Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTIKJl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 05:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbTIKJlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 05:41:55 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60944 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261188AbTIKJlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 05:41:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: nasm over gas?
Date: Wed, 10 Sep 2003 00:37:59 +0300
X-Mailer: KMail [version 1.4]
Cc: Michael Frank <mhf@linuxmail.org>, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org> <m18yp0o2mq.fsf@ebiederm.dsl.xmission.com> <20030907193030.GA21936@mail.jlokier.co.uk>
In-Reply-To: <20030907193030.GA21936@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309100037.59953.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 September 2003 22:30, Jamie Lokier wrote:
> Eric W. Biederman wrote:
> > Actually it is no as simple as that.  With the instruction that uses
> > %edi following immediately after the instruction that populates it you
> > cannot execute those two instructions in parallel.  So the code may be
> > slower.  The exact rules depend on the architecture of the cpu.
>
> I remember inserting a "nop" into a loop and it went significantly
> faster on a Pentium Pro :)

My example in _not_ a loop, far from it. That's the point.
GCC thinks everything is a loop.

> > If you concentrate on those handful of places where you need to
> > optimize that is reasonable.  Beyond that there simply are not the
> > developer resources to do good assembly.  And things like algorithmic
> > transformations in assembly are an absolute nightmare.  Where they are
> > quite simple in C.
>
> If we had enough developer resources to write the whole thing in good
> assembly, then for _sure_ we'd have enough to write a perfect compiler!

Peace, Jamie. I do _not_ advocate using asm anywhere except speed critical
code.
-- 
vda
