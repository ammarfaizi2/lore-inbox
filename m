Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284175AbRLTLQ0>; Thu, 20 Dec 2001 06:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284144AbRLTLQQ>; Thu, 20 Dec 2001 06:16:16 -0500
Received: from mons.uio.no ([129.240.130.14]:13504 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284153AbRLTLQD>;
	Thu, 20 Dec 2001 06:16:03 -0500
To: David Chow <davidchow@rcn.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsroot dead slow with redhat 7.2
In-Reply-To: <3C2131FC.6040209@rcn.com.hk> <shs6672n25h.fsf@charged.uio.no>
	<1008812943.16827.1.camel@star9.planet.rcn.com.hk>
	<15393.20331.862567.47007@charged.uio.no>
	<1008836323.972.6.camel@star7.planet.rcn.com.hk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Dec 2001 12:15:53 +0100
In-Reply-To: <1008836323.972.6.camel@star7.planet.rcn.com.hk>
Message-ID: <shsadwef8gm.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Chow <davidchow@rcn.com.hk> writes:

     > Just find out... it is a problem of some settings in /etc
     > directory it is not related to the FSes . I replaced the /etc
     > directory with the one we are using on the production
     > machines... by the way. What can be wrong? When it starts init
     > , and execute the /etc/rc.d/rc.sysinit , it is hell slow. We
     > have tried replace /sbin/init with bash and we got out a shell
     > but "ls -l" takes more than 2 minutes... do you know what sort
     > of settings in the /etc will affect use space "bash" or "glibc"
     > on nfsroot behaves different ? This is so strange.

Anything network related: ipchains, network parameters, ...
Also, if things like portmapper, statd, and the remaining NFS mounts
are getting started in the wrong order.

Cheers,
  Trond
