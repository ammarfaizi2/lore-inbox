Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286212AbRLTITK>; Thu, 20 Dec 2001 03:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286211AbRLTITB>; Thu, 20 Dec 2001 03:19:01 -0500
Received: from [210.176.202.14] ([210.176.202.14]:44716 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S286209AbRLTISw> convert rfc822-to-8bit; Thu, 20 Dec 2001 03:18:52 -0500
Subject: Re: nfsroot dead slow with redhat 7.2
From: David Chow <davidchow@rcn.com.hk>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <15393.20331.862567.47007@charged.uio.no>
In-Reply-To: <3C2131FC.6040209@rcn.com.hk> <shs6672n25h.fsf@charged.uio.no>
	<1008812943.16827.1.camel@star9.planet.rcn.com.hk> 
	<15393.20331.862567.47007@charged.uio.no>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 Dec 2001 16:18:42 +0800
Message-Id: <1008836323.972.6.camel@star7.planet.rcn.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

¦b ¶g¥|, 2001-12-20 10:39, Trond Myklebust ¼g¹D¡G
> >>>>> " " == David Chow <davidchow@rcn.com.hk> writes:
> 
>      > The network is fine. It is so slow that an ls -l at the rootfs
>      > takes more than 2 minutes. The readdir() seems alright because
>      > the ls immediate counts the number of records says "total
>      > blahbalh" but when doing individual lookup calls, it seems slow
>      > like hell. We have other production i686smp servers 2.4.14
> 
> As I said: 'tcpdump' ought to show you what is going on
> 
>      > serving diskless i686 clients using
>      > 2.4.13 kernels works great. Is there any difference in nfsroot
>      >        with
>      > normal nfsmounts? And can we configure the nfsroot use a v3
> 
> Nope: no differences. NFSroot uses the exact same code as standard
> NFS.
> 
>      > mount?  becaus now it defaults to v2 always.
> 
> As I said in my previous mail: use the mount option 'v3' on the kernel
> boot line if you want NFSv3.
> 
>  e.g. nfsroot="10.0.0.1:/bar,v3"
> 
> Cheers,
>    Trond
Just find out... it is a problem of some settings in /etc directory 
it is not related to the FSes . I replaced the /etc directory with the
one we are using on the production machines... by the way. What can be
wrong? When it starts init , and execute the /etc/rc.d/rc.sysinit , it
is hell slow. We have tried replace /sbin/init with bash and we got out
a shell but "ls -l" takes more than 2 minutes... do you know what sort
of settings in the /etc will affect use space "bash" or "glibc" on
nfsroot behaves different ? This is so strange.

Thanks

David

