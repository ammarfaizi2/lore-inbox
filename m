Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbQKUVWT>; Tue, 21 Nov 2000 16:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131259AbQKUVWK>; Tue, 21 Nov 2000 16:22:10 -0500
Received: from jalon.able.es ([212.97.163.2]:56048 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131227AbQKUVWB>;
	Tue, 21 Nov 2000 16:22:01 -0500
Date: Tue, 21 Nov 2000 21:51:45 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: beware of dead string constants
Message-ID: <20001121215145.C748@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <14874.25691.629724.306563@wire.cadcamlab.org> <20001121071327.R1514@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20001121071327.R1514@devserv.devel.redhat.com>; from jakub@redhat.com on Tue, Nov 21, 2000 at 13:13:27 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Nov 2000 13:13:27 Jakub Jelinek wrote:
> On Tue, Nov 21, 2000 at 06:02:35AM -0600, Peter Samuelson wrote:
> > 
> > While trying to clean up some code recently (CONFIG_MCA, hi Jeff), I
> > discovered that gcc 2.95.2 (i386) does not remove dead string
> > constants:
> > 
> >   void foo (void)
> >   {
> >     if (0)
> >       printk(KERN_INFO "bar");
> >   }
> > 

Is it related to opt level ? -O3 does auto-inlining and -O2 does not
(discovered that here, auto inlining in kernel trashes the cache...)

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre22-vm #7 SMP Sun Nov 19 03:29:20 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
