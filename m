Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315187AbSECSjA>; Fri, 3 May 2002 14:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315181AbSECShg>; Fri, 3 May 2002 14:37:36 -0400
Received: from pop.gmx.de ([213.165.64.20]:41292 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315155AbSECShS>;
	Fri, 3 May 2002 14:37:18 -0400
Date: Fri, 3 May 2002 20:36:00 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #2
Message-Id: <20020503203600.5ace492d.sebastian.droege@gmx.de>
In-Reply-To: <20020503193006.6b4b9094.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.)?ii'QGHd+1L/f"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.)?ii'QGHd+1L/f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2002 19:30:06 +0200
Sebastian Droege <sebastian.droege@gmx.de> wrote:

> On Fri, 3 May 2002 19:01:18 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > > > ide_tcq_intr_timeout: timeout waiting for interrupt...
> > > > > ide_tcq_intr_timeout: hwgroup not busy
> > > > 
> > > > We timed out waiting for an interrupt for service or dma completion.
> > > > Damn, I forgot to print which one. Please change that printk in
> > > > drivers/ide/ide-tcq.c:ide_tcq_intr_timeout() to:
> > > > 
> > > > 	printk("ide_tcq_intr_timeout: timeout waiting for %s interrupt...\n",
> > > > 		hwgroup->rq ? "completion" : "service");
> > > > 
> > > > and reproduce!
> > > Is this printk enough or should I handcopy the oops again? ;)
> > 
> > The oops is pretty irrelevant here, the fact that it triggers is enough
> > to know. I already know the backtrace :-)
> 
> It's a service interrupt....
> I'm currently recompiling without preempt

Ok... the problem doesn't solve simple by disabling preempt :(

Bye
--=.)?ii'QGHd+1L/f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE80tiUe9FFpVVDScsRAromAJ9Z3BXAx1LL0ZAy2003dQyR+1t7gQCfRhqS
2LWo3PNV6WsK+Jt1/IV2Tvw=
=Crdw
-----END PGP SIGNATURE-----

--=.)?ii'QGHd+1L/f--

