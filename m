Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315597AbSEJSor>; Fri, 10 May 2002 14:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313568AbSEJSoq>; Fri, 10 May 2002 14:44:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:374 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315597AbSEJSop>; Fri, 10 May 2002 14:44:45 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>, chen_xiangping@emc.com,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A42@srgraham.eng.emc.com>
	<3CDBFF5B.32550.1364FB2@localhost> <3CDBE7EB.9060605@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 May 2002 12:36:06 -0600
Message-ID: <m1n0v7zw89.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Pedro M. Rodrigues wrote:
> 
> >   Actually there is. Think iSCSI. Have a look at this article at LinuxJournal
> > - http://linuxjournal.com/article.php?sid=4896 .
> >
> 
> Ug...  why bother?  Just buy an SMP system at that point...

Or equally fix the kernel driver to do interrupt mitigation.  From
the article that looks like all they have managed to achieve.  There
may be a valid argument buried in there for remote DMA as well.

But given in the low contention case the kernel with it's own network
drivers was twice as fast.  tcp/ip offload looks to have some serious
weaknesses even for iSCSI.  The embedded processor kept better
performance going for just a little while but then it's performance
crashed as well.

Plus there is the general rule.  The primary CPU, it's memory, and
it's I/O subsystem improve out of necessity, while IO processors
stagnate, because they can.  The only exception to this I have seen
are graphics coprocessors.

Eric
