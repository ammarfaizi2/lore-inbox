Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbRLTCkT>; Wed, 19 Dec 2001 21:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285831AbRLTCkK>; Wed, 19 Dec 2001 21:40:10 -0500
Received: from pat.uio.no ([129.240.130.16]:52200 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S285828AbRLTCju>;
	Wed, 19 Dec 2001 21:39:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15393.20331.862567.47007@charged.uio.no>
Date: Thu, 20 Dec 2001 03:39:39 +0100
To: David Chow <davidchow@rcn.com.hk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: nfsroot dead slow with redhat 7.2
In-Reply-To: <1008812943.16827.1.camel@star9.planet.rcn.com.hk>
In-Reply-To: <3C2131FC.6040209@rcn.com.hk>
	<shs6672n25h.fsf@charged.uio.no>
	<1008812943.16827.1.camel@star9.planet.rcn.com.hk>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Chow <davidchow@rcn.com.hk> writes:

     > The network is fine. It is so slow that an ls -l at the rootfs
     > takes more than 2 minutes. The readdir() seems alright because
     > the ls immediate counts the number of records says "total
     > blahbalh" but when doing individual lookup calls, it seems slow
     > like hell. We have other production i686smp servers 2.4.14

As I said: 'tcpdump' ought to show you what is going on.

     > serving diskless i686 clients using
     > 2.4.13 kernels works great. Is there any difference in nfsroot
     >        with
     > normal nfsmounts? And can we configure the nfsroot use a v3

Nope: no differences. NFSroot uses the exact same code as standard
NFS.

     > mount?  becaus now it defaults to v2 always.

As I said in my previous mail: use the mount option 'v3' on the kernel
boot line if you want NFSv3.

 e.g. nfsroot="10.0.0.1:/bar,v3"

Cheers,
   Trond
