Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293541AbSCaADV>; Sat, 30 Mar 2002 19:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293596AbSCaADM>; Sat, 30 Mar 2002 19:03:12 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:58628 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293541AbSCaADA>;
	Sat, 30 Mar 2002 19:03:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7 
In-Reply-To: Your message of "Sun, 31 Mar 2002 09:48:38 +1000."
             <15526.20182.949443.871413@notabene.cse.unsw.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 31 Mar 2002 10:02:50 +1000
Message-ID: <11499.1017532970@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Mar 2002 09:48:38 +1000 (EST), 
Neil Brown <neilb@cse.unsw.edu.au> wrote:
>I cannot see the weak aliases being a real fix either.
>If you compile with NFSD as a module, and with CONFIG_KMOD, then the
>nfssvc_ctl systemcall is suppose to auto-load nfsd.o.  How can this be
>achieved with weak aliases?

System calls cannot be in modules.  Linus forbids it (that way lies
"extend and embrace") and at least two architectures (ia64, ppc64)
break when a syscall is in a module.

