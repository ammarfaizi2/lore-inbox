Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbRGLGNY>; Thu, 12 Jul 2001 02:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbRGLGNN>; Thu, 12 Jul 2001 02:13:13 -0400
Received: from web13705.mail.yahoo.com ([216.136.175.138]:44553 "HELO
	web13705.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267439AbRGLGM5>; Thu, 12 Jul 2001 02:12:57 -0400
Message-ID: <20010712061258.9093.qmail@web13705.mail.yahoo.com>
Date: Wed, 11 Jul 2001 23:12:58 -0700 (PDT)
From: parviz dey <parviz_linux@yahoo.com>
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
To: Lance Larsh <llarsh@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lance,

interesting stuff!!
Did u ever found out why this would happen??
any idea??

--- Lance Larsh <llarsh@oracle.com> wrote:
> On Wed, 11 Jul 2001, Brian Strand wrote:
> 
> > Our Oracle configuration is on reiserfs on lvm on
> Mylex.
> 
> I can pretty much tell you it's the reiser+lvm
> combination that is hurting
> you here.  At the 2.5 kernel summit a few months
> back, I reported that
> some of our servers experienced as much as 10-15x
> slowdown after we moved
> to 2.4.  As it turned out, the problem was that the
> new servers (with
> identical hardware to the old servers) were
> configured to use reiser+lvm,
> whereas the older servers were using ext2 without
> lvm.  When we rebuilt
> the new servers with ext2 alone, the problem
> disappeared.  (Note that we
> also tried reiserfs without lvm, which was 5-6x
> slower than ext2 without
> lvm.)
> 
> I ran lots of iozone tests which illustrated a huge
> difference in write
> throughput between reiser and ext2.  Chris Mason
> sent me a patch which
> improved the reiser case (removing an unnecessary
> commit), but it was
> still noticeably slower than ext2.  Therefore I
> would recommend that
> at this time reiser should not be used for Oracle
> database files.
> 
> Thanks,
> Lance
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
