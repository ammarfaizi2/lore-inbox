Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSKMRkk>; Wed, 13 Nov 2002 12:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbSKMRkk>; Wed, 13 Nov 2002 12:40:40 -0500
Received: from mailout.zma.compaq.com ([161.114.64.105]:30729 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S262147AbSKMRkj>; Wed, 13 Nov 2002 12:40:39 -0500
From: Bruce Walker <bruce@kahuna.lax.cpqcorp.net>
Message-Id: <200211131747.gADHlSs03356@kahuna.lax.cpqcorp.net>
Subject: Re: [SSI] Re: Distributed Linux
In-Reply-To: <1037164404.16105.12.camel@satan.xko.dec.com> from "Aneesh Kumar K.V" at "Nov 13, 2002 10:43:24 am"
To: aneesh.kumar@digital.com (Aneesh Kumar K.V)
Date: Wed, 13 Nov 2002 09:47:28 -0800 (PST)
Cc: prasad_s@gdit.iiit.net, linux-kernel@vger.kernel.org (linux-kernel),
       ssic-linux-devel@lists.sourceforge.net (ssic-linux-devel)
X-Mailer: ELM [version 2.4ME+ PL54 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As a graduation project i intended to make linux distributed 

snip
> 
> >The guest system (where the process originated) would
> >however have a pseudo process running on it, which would not take much
> >resources but would help in handling various signals/
> 
> SSI support cluster wide signaling. That means you can send signal to a
> process running on other node( you have cluster wide PID )
> 
The openSSI process model is quite different than Bproc or Mosix or
your "guest system" proposal.  In the openSSI model, there is no
pseudo or shadow process at the processes creation node;  after
a processes migrates, all its system calls are executed on the new
node and signalling to the process is done directly to the process on
the new node.  Besides the obvious performance advantages this can
give, it can also provide availability advantages because the 
creation node can go down without taking the process down with it.

bruce


> 
> -aneesh 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: 
> To learn the basics of securing your web site with SSL, 
> click here to get a FREE TRIAL of a Thawte Server Certificate: 
> http://www.gothawte.com/rd522.html
> _______________________________________________
> ssic-linux-devel mailing list
> ssic-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ssic-linux-devel

