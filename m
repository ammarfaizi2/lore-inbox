Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288567AbSADJbW>; Fri, 4 Jan 2002 04:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288562AbSADJbQ>; Fri, 4 Jan 2002 04:31:16 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:21776 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288567AbSADJbE>;
	Fri, 4 Jan 2002 04:31:04 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15413.30191.775842.715207@argo.ozlabs.ibm.com>
Date: Fri, 4 Jan 2002 20:29:19 +1100 (EST)
To: Pavel Machek <pavel@suse.cz>
Cc: Tom Rini <trini@kernel.crashing.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020103233942.A12380@elf.ucw.cz>
In-Reply-To: <E16Lvh8-0006E6-00@the-village.bc.nu>
	<25193.1010018130@redhat.com>
	<20020103021021.GW1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020103233942.A12380@elf.ucw.cz>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:

> gcc is allowed not to pass it anywhere. You may not second guess
> optimizer. If it is not defined, it is not defined.
> 
> Imagine
> 
> strcpy(a, "xyzzy"+b);
> if (b>16)
> 	printf("foo");
> 
> . gcc is permitted to kill printf(), because if b<0 or b>16 behaviour is
> undefined. So gcc may assume b<=16.

So... I'm curious.  How is the result of virt_to_phys ever anything
other than undefined?

Paul.
