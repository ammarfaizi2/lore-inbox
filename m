Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281116AbRKKWRd>; Sun, 11 Nov 2001 17:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281124AbRKKWRN>; Sun, 11 Nov 2001 17:17:13 -0500
Received: from moon.govshops.com ([207.32.111.5]:63236 "HELO mail.govshops.com")
	by vger.kernel.org with SMTP id <S281116AbRKKWRE>;
	Sun, 11 Nov 2001 17:17:04 -0500
From: "Alok K. Dhir" <alok@dhir.net>
To: "'Mike Fedyk'" <mfedyk@matchmail.com>, "'J Sloan'" <jjs@pobox.com>
Cc: "'Sven Vermeulen'" <sven.vermeulen@rug.ac.be>,
        "'Linux-Kernel Development Mailinglist'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: Networking: repeatable oops in 2.4.15-pre2
Date: Sun, 11 Nov 2001 17:16:58 -0500
Message-ID: <001101c16afe$9478b2a0$1e01a8c0@PEARL>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20011110151441.D446@mikef-linux.matchmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the exact same problem, and removing the 4 netfilter patches
mailed to this list in an earlier post in this thread has solved the
problem for me.

UP box, preempt kernel patch, APIC enabled, running iptables based
firewall with NAT and filtering enabled...

Al

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Mike Fedyk
> Sent: Saturday, November 10, 2001 6:15 PM
> To: J Sloan
> Cc: Sven Vermeulen; Linux-Kernel Development Mailinglist
> Subject: Re: Networking: repeatable oops in 2.4.15-pre2
> 
> 
> On Sat, Nov 10, 2001 at 10:48:11AM -0800, J Sloan wrote:
> > Sven Vermeulen wrote:
> > 
> > > J Sloan (jjs@pobox.com) wrote:
> > > > I have been running the 2.4.15-pre kernels and
> > > > have found an interesting oops. I can reproduce
> > > > it immediately, and reliably, just by issuing an ssh 
> command (as a 
> > > > normal user).
> > >
> > > I'm currently running Linux 2.4.15-pre2 and have no troubles with 
> > > ssh. I can safely login onto other hosts, or issuing commands like
> > >         ssh -l someuser@somehost mutt
> > > or copy files
> > >         scp somefile someuser@somehost:
> > >
> > > I'm not using OpenSSH 3.0 yet (2.9p2). I'm not running 
> any firewall 
> > > or transparent proxying.
> > 
> > Thanks for the info, this is what I suspected -
> > 
> > only people running iptables appear to be
> > seeing this problem.
> > 
> 
> I don't know...
> 
> I have netfilter compiled in, but I don't have any filter 
> rules yet.  This is on smp too...
> 
> Have you been able to tell if you need to use mangling, or 
> nat, or will just filter rules do the job of reproducing?
> 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the 
> FAQ at  http://www.tux.org/lkml/
> 

