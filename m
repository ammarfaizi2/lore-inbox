Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSH0MMQ>; Tue, 27 Aug 2002 08:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSH0MMQ>; Tue, 27 Aug 2002 08:12:16 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:20221 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315746AbSH0MMP>;
	Tue, 27 Aug 2002 08:12:15 -0400
Date: Tue, 27 Aug 2002 22:16:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jan Hudec <bulb@cimice.maxinet.cz>
Cc: bulb@vagabond.cybernet.cz, bulb@cimice.maxinet.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Question about leases
Message-Id: <20020827221618.5c7d0b46.sfr@canb.auug.org.au>
In-Reply-To: <20020827084244.GA23077@vagabond>
References: <20020827010616.GB16207@vagabond>
	<20020827143517.40ba04f7.sfr@canb.auug.org.au>
	<20020827084244.GA23077@vagabond>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Tue, 27 Aug 2002 10:42:44 +0200 Jan Hudec <bulb@cimice.maxinet.cz> wrote:
>
> One more question. Does the siginfo contain information weather is's
> read or write that the other process attempted? And does it contain the

No, you need to do fcntl(fd, F_GETLEASE) to find out what kind of
lease you need to set to satisfy the other process i.e. if the other
process does an open for reading then GETLEASE will return F_RDLCK
and if they attempt an open for writing the GETLEASE will return F_UNLCK.

> operation type for directory notifications?

No, sorry.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
