Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSJQN1M>; Thu, 17 Oct 2002 09:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbSJQN1M>; Thu, 17 Oct 2002 09:27:12 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:55305 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S261541AbSJQN1L>;
	Thu, 17 Oct 2002 09:27:11 -0400
Date: Thu, 17 Oct 2002 22:26:02 +0900 (JST)
Message-Id: <20021017.222602.48536782.taka@valinux.co.jp>
To: habanero@us.ibm.com
Cc: neilb@cse.unsw.edu.au, davem@redhat.com, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <003301c275e1$0bf76810$2a060e09@beavis>
References: <012d01c27581$677d2180$2a060e09@beavis>
	<20021017.113126.102592502.taka@valinux.co.jp>
	<003301c275e1$0bf76810$2a060e09@beavis>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> server: Udp: InDatagrams NoPorts InErrors OutDatagrams
>         Udp: 1000665 41 0 1000666
> clients: Udp: InDatagrams NoPorts InErrors OutDatagrams
>          Udp: 200403 0 0 200406
>          (all clients the same)

How about IP datagrams?  You can see the IP fields in /proc/net/snmp
IP layer may also discard them.

> > And how many threads did you start on your machine?
> > Buffer size of a UDP socket depends on number of kNFS threads.
> > Large number of threads might help you.
> 
> 128 threads.  client rsize=8196.  Server and client MTU is 1500.

It seems enough...

