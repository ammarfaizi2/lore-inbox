Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSHaAqg>; Fri, 30 Aug 2002 20:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSHaAqf>; Fri, 30 Aug 2002 20:46:35 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:54512
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315414AbSHaAqe>; Fri, 30 Aug 2002 20:46:34 -0400
Subject: Re: [PATCH] Introduce BSD-style user credential [3/3]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dave McCracken <dmccr@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208301741430.5561-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 01:51:04 +0100
Message-Id: <1030755064.1225.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-31 at 01:49, Linus Torvalds wrote:
> > struct pcred {
> >        atomic_t	count;
> >        uid_t	uid, euid, suid;
> >        gid_t	gid, egid, sgid;
> >        struct ucred  *cred;
> >        kernel_cap_t ... capabilities ...
> >        struct user_struct *user;
> > };
> 

Needs fsuid too, and space for the security LSM modules to attach
private information. SELinux needs a few more credentials than base
kernels!


