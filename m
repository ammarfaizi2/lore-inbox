Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbSKTJNP>; Wed, 20 Nov 2002 04:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbSKTJNP>; Wed, 20 Nov 2002 04:13:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2135 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266010AbSKTJNO>; Wed, 20 Nov 2002 04:13:14 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7 -- Success Story!
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org>
	<1037668241.10400.48.camel@andyp> <m1isyt26wr.fsf@frodo.biederman.org>
	<1037726468.10400.81.camel@andyp> <m1adk51n0e.fsf@frodo.biederman.org>
	<4090000.1037729868@flay>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Nov 2002 02:19:31 -0700
In-Reply-To: <4090000.1037729868@flay>
Message-ID: <m1of8kzjh8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> Just to make sure I understand the problem.  Until we can make all
> >> boot-time BIOS calls work, we need a way to:
> > 
> > A small clarification.  BIOS calls will never work 100%.  Especially in the
> > interesting cases like kexec on panic.  So entering the kernel in
> > 32bit mode will continue to be the default mode of.  This means the
> > final solution to problems like this needs to be a good one.
> 
> Do we still have the mpstables and other such initdata around as well?

The mp tables, and all of the other tables we pick up after we are
in 32bit mode the kernel explicitly preserves and leaves right where
they are.  There is no need to do anything to convey them to the next
kernel as pointers to them are in well known locations. 

Eric

