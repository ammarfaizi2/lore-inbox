Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTIVTTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTIVTTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:19:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:36225 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263290AbTIVTTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:19:32 -0400
Date: Mon, 22 Sep 2003 20:19:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: arjanv@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80, in 2.6?
Message-ID: <20030922191921.GD27209@mail.jlokier.co.uk>
References: <m1isnlk6pq.fsf@ebiederm.dsl.xmission.com> <1064229778.8584.2.camel@dhcp23.swansea.linux.org.uk> <20030922162602.GB27209@mail.jlokier.co.uk> <1064248391.8895.6.camel@dhcp23.swansea.linux.org.uk> <1064250691.6235.2.camel@laptop.fenrus.com> <m165jkk5vn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m165jkk5vn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Alan, can you describe a little more what the original delay is needed
> for?  I don't see it documented in my 8254 data sheet.  The better I
> can understand the problem the better I can write the comments on this
> magic bit of code as I fix it.
> 
> The oldest machine I have is a 386 MCA system.  Any chance of the bug
> showing up there?  I'd love to have a test case.
> 
> Another reason for fixing this is we are killing who knows how much
> I/O bandwidth with this stream of failing writes to port 0x80.

Unfortunately, a lot of drivers use the _p operators so if the delay
is simply removed, it may take a while before the ill effects of that
are discovered.

-- Jamie
