Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136827AbRECOzi>; Thu, 3 May 2001 10:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136826AbRECOz3>; Thu, 3 May 2001 10:55:29 -0400
Received: from mail0.bna.bellsouth.net ([205.152.150.12]:59780 "EHLO
	mail0.bna.bellsouth.net") by vger.kernel.org with ESMTP
	id <S136822AbRECOzM> convert rfc822-to-8bit; Thu, 3 May 2001 10:55:12 -0400
From: volodya@mindspring.com
Date: Thu, 3 May 2001 10:54:59 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
cc: liste noyau linux <linux-kernel@vger.kernel.org>,
        liste dev network device <netdev@oss.sgi.com>
Subject: Re: NEWBEE "reverse ioctl" or someting like
In-Reply-To: <20010503142929.773147bf.sebastien.person@sycomore.fr>
Message-ID: <Pine.LNX.4.20.0105031053130.928-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a) just make your management app periodically issue 
  ioctl(fd, GET_CONFIG_INFO, ...)
and make the driver return -1 when the info is not present

b) make a new device and open it with management app

c) make a new node in /proc and open it with management app 
  (cons: requires /proc to be mounted)

d) kernel-user netlink socket (never tried myself)

                     Vladimir Dergachev

On Thu, 3 May 2001, [ISO-8859-1] sébastien person wrote:

> hi,
> 
> I've made a network driver wich is attached to the serial port.
> The network hardware is able to return information to the pc. theses
> informations are belong to the configuration of the hardware. I 
> succeed on receive information in the driver but I've no idea to alert
> higher process (like configuration app ...) that I've received something
> (wich is not network data like TCP or ARP etc ...).
> 
> I think that use of pipe isn't preconised because I must fork process
> to use pipe, I search something like ioctl but in the other way : 
> 
>  kernel process ---> user process
> 
> Is somebody know the best and easy way ??
> 
> thank (I hope this is the right place to ask)
> 
> sebastien person
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

