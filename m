Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271082AbRICCYi>; Sun, 2 Sep 2001 22:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271085AbRICCY2>; Sun, 2 Sep 2001 22:24:28 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:42251 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271082AbRICCYP>; Sun, 2 Sep 2001 22:24:15 -0400
From: volodya@mindspring.com
Date: Sun, 2 Sep 2001 22:25:44 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: Jeremiah Johnson <miah@netcis.com>
cc: Steve Kieu <haiquy@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: 2.4.9 UDP broke?
In-Reply-To: <67111542696.20010831084646@netcis.com>
Message-ID: <Pine.LNX.4.20.0109022221340.14074-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Aug 2001, Jeremiah Johnson wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: MD5
> 
> Hello Steve,
> 
> Thursday, August 30, 2001, 10:50:08 PM, you wrote:
> 
> SK>  --- Jeremiah Johnson <miah@netcis.com> wrote: >
> SK> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: MD5
> >>
> >> Hello linux-kernel,
> >>
> >>   I am having very strange problems with 2.4.9 and
> >> UDP.  Basically,
> >>   anything using UDP wont work.  Anything using
> >> TCP/ICMP works fine.
> 
> SK> May be it is not the kernel, I dont know but in my box
> SK> it works as normal
> 
> SK> (I can use speakfreely ; it uses UDP and otehr program
> SK> too)
> 
> Well considering the only thing I changed in my configuration is the
> kernel, I think its a problem there.  Went from 2.4.3-ac? to 2.4.9.
> System is RedHat 7.1.. Maybe it has something to do with RedHats
> inclusion of a broken compiler, I'll have to check on that when I get
> into the office.

I had a very similar experience. In my case it turned out that for some
reason no UDP packets above 5524 would come through (try pinging with
larger than default packet sizes). The solution was to restrict NFS to
5000 (actually 4096) size packets. I have not been able to figure out the
cause of this yet. (and yes, tcpdump was able to see them fine).

                            Vladimir Dergachev

> 
> I do have 2.4.9 working fine on other systems too.  Strange.
> - --
> Best regards,
>  Jeremiah                            mailto:miah@netcis.com
> 
> -----BEGIN PGP SIGNATURE-----
> Version: 2.6
> 
> iQEVAwUAO4+xapHTj7BlqKb5AQE/sQf+MNVYf4Dv4KRS2V3jiexwdlwpAUyNGUDp
> VUli3po/IuoBsiz0zubCK0tFSVMB/2o24kYzAFIBKajrQP7uVVSUqbQzWpwWazpg
> Vu3wAnHx3oPBpWmF3fxrMGjC/1g4FKUAnmBKne8VQOPaEVy+iUxZy5VQhXYXoBs0
> O98+7VzgxjPI7txEmmqcJdLJHy7hQSuKvN9+FYvDmueeWeZV909NuH9P3Estp00c
> HtuKAb57wkea8CcoZlknr+Iuei7geRAti4iGrGMYEVFNTYQxVVSC/FGM+T4UP1ia
> R08TX47WHR2sucVatXv8oT/ixyepo82D0xIHbBltYLB8yqC/JxkDYA==
> =5GKB
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


