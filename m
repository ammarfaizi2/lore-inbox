Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbREXXAH>; Thu, 24 May 2001 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbREXW75>; Thu, 24 May 2001 18:59:57 -0400
Received: from pobox.sibyte.com ([208.12.96.20]:14599 "HELO pobox.sibyte.com")
	by vger.kernel.org with SMTP id <S262490AbREXW7q>;
	Thu, 24 May 2001 18:59:46 -0400
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        engler@csl.Stanford.EDU (Dawson Engler)
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
Date: Thu, 24 May 2001 15:55:32 -0700
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1533qI-0005jT-00@the-village.bc.nu>
In-Reply-To: <E1533qI-0005jT-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <0105241559150L.01510@plugh.sibyte.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/rio/rio_linux.c:1036:rio_init_datastructures: ERROR:FREE:1031:1036: WARN: Use-after-free of "RIOHosts"! set by 'kfree':1031
> >         kfree (p->RIOPortp[i]);
> > 	rio_dprintk (RIO_DEBUG_INIT, "Not enough memory! %p %p %p %p %p\n", 
> > Error --->
> >         	       p, p->RIOHosts, p->RIOPortp, rio_termios, rio_termios);
> 
> Not a bug - you need to teach your code that printf has formats that print the
> value of a pointer not dereference it
> 

Take another look.  p is potentially bogus here, meaning those p->RIOHosts and
p->RIOPortp references are bad.

-Justin
