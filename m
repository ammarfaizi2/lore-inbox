Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264742AbSJUG2t>; Mon, 21 Oct 2002 02:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSJUG2t>; Mon, 21 Oct 2002 02:28:49 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:29587 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264742AbSJUG2s>;
	Mon, 21 Oct 2002 02:28:48 -0400
Date: Mon, 21 Oct 2002 08:34:54 +0200
From: bert hubert <ahu@ds9a.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsd/sunrpc boot on reboot in 2.5.44
Message-ID: <20021021063454.GA5898@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
References: <20021020173142.GA26384@outpost.ds9a.nl> <15795.29666.121485.737045@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15795.29666.121485.737045@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 01:26:26PM +1000, Neil Brown wrote:

> > By the way, can anybody tell me how to convert this:
> > Oct 20 19:21:32 hubert kernel:  [<c8831060>] auth_domain_drop+0x50/0x60 [sunrpc]
> > 
> > To a line in auth_domain_drop()?
> 
>  gdb sunrpc.o
>  disassemble auth_domain_drop
> 
>  stare at assembler listing, stare at source code....

I also found this to work:

touch sunrpc.c
make
[ observe how sunrpc.o gets compiled ]
[ add a -g to the commandline ]
gdb sunrpc.o
l *(auth_domain_drop+0x50)

"A #kernelnewbies discovery".

Thanks for the switch patch! Will check if it helps.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
