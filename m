Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132025AbRAXOSj>; Wed, 24 Jan 2001 09:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132343AbRAXOSa>; Wed, 24 Jan 2001 09:18:30 -0500
Received: from smtp6.mail.yahoo.com ([128.11.69.103]:51973 "HELO
	smtp6.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132025AbRAXOSS>; Wed, 24 Jan 2001 09:18:18 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A6ED972.6636E169@yahoo.com>
Date: Wed, 24 Jan 2001 08:32:35 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.1-pre8 i486)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: David Luyer <david_luyer@pacific.net.au>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: "Pass module parameters" to built-in drivers
In-Reply-To: <27169.980053744@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> Inconsistent methods for setting the same parameter are bad.  I can and
> will do this cleanly in 2.5.  Parameters will be always be keyed by the
> module name, even if they are compiled in.  Adding an inconsistent

I'm curious as to what boot argument equivalent you envision for e.g.

options ne io=0x280,0x300 irq=10,12 bad=0,1

> method to 2.4 then changing to a correct method in 2.5 is a bad idea,
> wait until we can do it right.

As a related issue, this will allow me (or whoever) to kill off the
ether=x,y,z,ethN boot argument for compiled in ethernet drivers at
the same time.  It made sense back in 1.0/1.2 days when distro kernels 
were shipped with everything compiled in and ISA cards were the norm.  
Now it is hardly used and generally a PITA to support.

Paul.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
