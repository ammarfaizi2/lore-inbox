Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285783AbRLTBtc>; Wed, 19 Dec 2001 20:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285778AbRLTBtW>; Wed, 19 Dec 2001 20:49:22 -0500
Received: from [210.176.202.14] ([210.176.202.14]:26027 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S285764AbRLTBtL> convert rfc822-to-8bit; Wed, 19 Dec 2001 20:49:11 -0500
Subject: Re: nfsroot dead slow with redhat 7.2
From: David Chow <davidchow@rcn.com.hk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <shs6672n25h.fsf@charged.uio.no>
In-Reply-To: <3C2131FC.6040209@rcn.com.hk>  <shs6672n25h.fsf@charged.uio.no>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 Dec 2001 09:49:03 +0800
Message-Id: <1008812943.16827.1.camel@star9.planet.rcn.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Trond,

Thanks for answering my question, we have use the i386 kernel at the
server that works fine. Also even we uses the i686 kerenl at the server,
it happens normally when doing NFS mounts, it will only be dead slow
when
	server i686 2.4.7-10 kernel && client nfsroot(2.4.13 i686)

The network is fine. It is so slow that an ls -l at the rootfs takes
more than 2 minutes. The readdir() seems alright because the ls
immediate counts the number of records says "total blahbalh" but when
doing individual lookup calls, it seems slow like hell. We have other
production i686smp servers 2.4.14 serving diskless i686 clients using
2.4.13 kernels works great. Is there any difference in nfsroot with
normal nfsmounts? And can we configure the nfsroot use a v3 mount?
becaus now it defaults to v2 always.

David

¦b ¶g¥|, 2001-12-20 08:52, Trond Myklebust ¼g¹D¡G
> >>>>> " " == David Chow <davidchow@rcn.com.hk> writes:
> 
>      > Dear all, When I use 2.4.7-10 i686 kernel from stock Redhat 7.2
>      > as the NFS server. My NFS client use the 2.4.13 kernel, when I
>      > mount the nfsroot to the server, I found it is dead slow on the
>      > client. This only happens in i686 kernel on the server, if we
>      > use a K6-2 uses an i386 server its fine. What's going on? By
> 
> Usually means you have a bad network connection. Use tcpdump to
> isolate where on the network packets (and UDP fragments) are
> disappearing.
> 
>      > the way, how to configure the client to default use a NFSv3
>      > mount? Thanks.
> 
> Specify the 'v3' NFSroot mount option.
> 
> Cheers,
>    Trond


