Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVLIFwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVLIFwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 00:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLIFwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 00:52:50 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:56608 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932371AbVLIFwu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 00:52:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lWZcmm9NwWN+MkZ965tPueVMfsEw2DDfQ7I4ThWTNiiWdrx4acxhHwVlFkdw1qLrWqN16aUzVl8guJm9Ld42Pa4VvZZkFDZv67gZ7wZ3BOGr0p3QkcatNcsJLvUOKsQ2fhQrD7YpqtaBUM2qN39k3nKZW4L9WNsCtuZ/CmJy0hw=
Message-ID: <993d182d0512082152xd76065aydfc7548e9f51ed94@mail.gmail.com>
Date: Fri, 9 Dec 2005 11:22:47 +0530
From: Conio sandiago <coniodiago@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Urgent work ! please help
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051207213547.GA15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <993d182d0512070225kbc4d926w5ab4255e4cdaea75@mail.gmail.com>
	 <20051207213547.GA15993@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Willy,
Thanks a lot for reply.
i have done some more investigation and now i have the following observation:-


1) When i analyse the packets using ethereal,
i saw some duplicate Acks from the reciever, after which
transmitter does fast -re transmission,
In this transmission i saw some TCP checksum incorrect messages.



2) Now if i disbale the DCACHE in the system , And then do the ftp,
everything works well.



No my doubt is

a) When does a transmitte do Fast Retransmission,?

b) if i disbale the cache then system performance goes very slow,
thats why everything goes well,

c) what is the case of collsion in the ethernet driver??

Please help
Thanks in advance
conio









On 12/8/05, Willy Tarreau <willy@w.ods.org> wrote:
> On Wed, Dec 07, 2005 at 03:55:32PM +0530, Conio sandiago wrote:
> > Hi all
> > i am conio,
> > i am facing some problems.
> > I have a embedded monta vista linux kernel running on arm processor,
> > the linux kernel version is 2.6.x
>
> First rule if you're looking for some help : be precise. 2.6.x is not
> a kernel version, and ARM is more a family than a processor.
>
> > I have developed a ethernet driver for the same.
>
> From your report below, I think that you now need to add some debug
> code to your driver. It seems reasonable that a new development is
> buggy at first, and a broken ethernet driver can easily lead to
> corrupted data.
>
> > But now i am facing a strange problems-
> >
> > 1) If i do a ftp for a very big file from one board to another pc
> > using a switching hub then
>
> what size ? what speed ? half/full duplex ? what transfer speed do
> you observe before the problem ?
>
> > At an early stage ftp-data is normally sent to LinuxPC. Then suddenly
> > the embedded linux  asks the IP address of LinuxPC with using ARP.
>
> it may simply mean that it has lost access to the other one and that
> the ARP cache has expired.
>
> > After this point it start taking a lot of time to transfer data with
> > ftp command.
> >
> > The packet analysis  shows there are  errors ,"TCP CHECKSUM INCORRECT".
>
> before asking, have you tried :
>  - change your switch and connect with a cross-over cable
>  - sending icmp, udp
>  - transfer in each direction separately to check whether it happens
>    on transmit / receive / both
>  - reduce MTU on one, then the other, then both ends
>  - ping during the transfer
>
> ?
>
> > Please help
> > if somebody has some idea
> > whether it can be a hardware / software bug???
>
> with so few information, it's hard to say. At most, we can deduce that
> you encountered a problem the first time you tried your fresh new driver.
>
> > Regards
> > conio
>
> Regards,
> Willy
>
>
