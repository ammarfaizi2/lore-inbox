Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSIFDWQ>; Thu, 5 Sep 2002 23:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSIFDWQ>; Thu, 5 Sep 2002 23:22:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42881 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318252AbSIFDWP>;
	Thu, 5 Sep 2002 23:22:15 -0400
Date: Thu, 05 Sep 2002 20:19:35 -0700 (PDT)
Message-Id: <20020905.201935.68230225.davem@redhat.com>
To: n0ano@n0ano.com
Cc: davidm@hpl.hp.com, rsreelat@in.ibm.com, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: patch for IA64: fix do_sys32_msgrcv bad
 address error.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905104312.A30920@willie.n0ano.com>
References: <OFFB350C4A.BB78D4E6-ON65256C2B.004CF605@in.ibm.com>
	<15735.35748.328193.108301@napali.hpl.hp.com>
	<20020905104312.A30920@willie.n0ano.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Don Dugger <n0ano@n0ano.com>
   Date: Thu, 5 Sep 2002 10:43:12 -0600

   Yes, but Dave Millier claims that this patch is still broken, he says the
   fix needs to be in `ipc_kludge'.  I don't have access to my source tree
   until this evening, have you looked at this?
   
You didn't read David's patch at all, this is exactly what he is
doing, fixing the ipc_kludge declaration.

   On Thu, Sep 05, 2002 at 09:51:48AM -0700, David Mosberger wrote:
   > diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
   > --- a/arch/ia64/ia32/sys_ia32.c	Thu Sep  5 09:51:05 2002
   > +++ b/arch/ia64/ia32/sys_ia32.c	Thu Sep  5 09:51:05 2002
   > @@ -2111,8 +2111,8 @@
   >  };
   >  
   >  struct ipc_kludge {
   > -	struct msgbuf *msgp;
   > -	long msgtyp;
   > +	u32 msgp;
   > +	s32 msgtyp;
   >  };
   >  
   >  #define SEMOP		 1

See?
