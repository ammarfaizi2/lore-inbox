Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbREMCSo>; Sat, 12 May 2001 22:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbREMCSf>; Sat, 12 May 2001 22:18:35 -0400
Received: from sunny.pacific.net.au ([210.23.129.40]:31720 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S261363AbREMCSX>; Sat, 12 May 2001 22:18:23 -0400
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "ashridah" <ashridah@pobox.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
X-Mailer: Pronto v2.2.5 On linux/mysql
Date: 12 May 2001 21:17:57 EST
Reply-To: "ashridah" <ashridah@pobox.com>
In-Reply-To: <Pine.A41.4.31.0105130055400.19270-100000@pandora.inf.elte.hu>
In-Reply-To: <Pine.A41.4.31.0105130055400.19270-100000@pandora.inf.elte.hu>
Message-Id: <E14ylSK-0000dO-00@mycrondo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 May 2001 01:00:39 +0200 (CEST), BERECZ Szabolcs said:

> Hi!
>  
>  root@kama3:/home/szabi# cat /proc/mounts
>  ...
>  /dev/hdb2 /usr ext2 rw 0 0
>  ...
>  root@kama3:/home/szabi# swapon /dev/hdb2
[snip]

hmm. while the technical issues of this situation are fairly interesting,
can i make a suggestion? if you're running out of swap every now and 
then, perhaps you need to use swapd (a userspace daemon, that adds
more swap from swapfiles as you need it, and recovers the space when
things become less pressing). that's much better than trying it by hand
when necessary. As you've noticed, we're all only human, and mistakes
can be made.

swapd: http://cvs.linux.hr/swapd/

as a side bonus, you get to keep that partition as a filesystem, and also
dedicate it to being the swapfile holder.

while this is a solution i'd never go in for (userspace is slightly more
fallible
than i like (which doesn't stop me from using devfsd) given the situation
swapd needs to act in), but it's better than doing it by hand, no?

Andrew 'ashridah' Pilley

>  do you need any other information?
>  
>  Bye,
>  Szabi
>  
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>  

