Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318332AbSIFEGw>; Fri, 6 Sep 2002 00:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318333AbSIFEGw>; Fri, 6 Sep 2002 00:06:52 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:64686 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S318332AbSIFEGv>; Fri, 6 Sep 2002 00:06:51 -0400
Subject: Re: [Linux-ia64] Re: patch for IA64: fix do_sys32_msgrcv bad address error.
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org,
       n0ano@n0ano.com
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF4A439348.08A49A21-ON65256C2C.00158181@in.ibm.com>
From: "R Sreelatha" <rsreelat@in.ibm.com>
Date: Fri, 6 Sep 2002 09:27:30 +0530
X-MIMETrack: Serialize by Router on d23m0062/23/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/09/2002 09:27:39 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,
      Thanks. Yes, changing the types in the ipc_kludge structure would be
correct way to patch. I have incorporated the change suggested by you in my
code patch.

regards,
Sreelatha




                                                                                                           
                      "David S. Miller"                                                                    
                      <davem@redhat.com        To:       n0ano@n0ano.com                                   
                      >                        cc:       davidm@hpl.hp.com, R Sreelatha/India/IBM@IBMIN,   
                                                linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org     
                      09/06/2002 08:49         Subject:  Re: [Linux-ia64] Re: patch for IA64: fix          
                      AM                        do_sys32_msgrcv bad address error.                         
                                                                                                           
                                                                                                           
                                                                                                           



   From: Don Dugger <n0ano@n0ano.com>
   Date: Thu, 5 Sep 2002 10:43:12 -0600

   Yes, but Dave Millier claims that this patch is still broken, he says
the
   fix needs to be in `ipc_kludge'.  I don't have access to my source tree
   until this evening, have you looked at this?

You didn't read David's patch at all, this is exactly what he is
doing, fixing the ipc_kludge declaration.

   On Thu, Sep 05, 2002 at 09:51:48AM -0700, David Mosberger wrote:
   > diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
   > --- a/arch/ia64/ia32/sys_ia32.c             Thu Sep  5 09:51:05 2002
   > +++ b/arch/ia64/ia32/sys_ia32.c             Thu Sep  5 09:51:05 2002
   > @@ -2111,8 +2111,8 @@
   >  };
   >
   >  struct ipc_kludge {
   > -             struct msgbuf *msgp;
   > -             long msgtyp;
   > +             u32 msgp;
   > +             s32 msgtyp;
   >  };
   >
   >  #define SEMOP                         1

See?




