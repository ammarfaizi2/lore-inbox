Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291512AbSBADqw>; Thu, 31 Jan 2002 22:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291513AbSBADqn>; Thu, 31 Jan 2002 22:46:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23694 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291512AbSBADqg>;
	Thu, 31 Jan 2002 22:46:36 -0500
Date: Thu, 31 Jan 2002 22:46:35 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020131224635.F21864@havoc.gtf.org>
In-Reply-To: <20020131.162549.74750188.davem@redhat.com> <E16WRmu-0003iO-00@the-village.bc.nu> <20020131.163054.41634626.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131.163054.41634626.davem@redhat.com>; from davem@redhat.com on Thu, Jan 31, 2002 at 04:30:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 04:30:54PM -0800, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Fri, 1 Feb 2002 00:42:44 +0000 (GMT)
>    
>    I'd like to eliminate lots of the magic weird cases in Config.in too - but
>    by making the language express it. Something like
>    
>    tristate_orif "blah" CONFIG_FOO $CONFIG_SMALL
>    
> This doesn't solve the CRC32 case.  What if you want
> CONFIG_SMALL, yet some net driver that needs the crc32
> routines?

Maybe not in this hypothetical future situation, but currently makefile
magic was added for crc32 specifically to ensure that it is linked
in when needed... even when CONFIG_CRC32=n.

The Config.in for crc32 only exists for the case where no driver in the
built kernel uses it... but a 3rd party module might want it.

	Jeff



