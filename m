Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292360AbSBUMzU>; Thu, 21 Feb 2002 07:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292359AbSBUMyi>; Thu, 21 Feb 2002 07:54:38 -0500
Received: from codepoet.org ([166.70.14.212]:48822 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S291625AbSBUMyb>;
	Thu, 21 Feb 2002 07:54:31 -0500
Date: Thu, 21 Feb 2002 05:54:31 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
Message-ID: <20020221125431.GB28759@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0202210011080.32476-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202210011080.32476-100000@serv>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.17-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 21, 2002 at 11:48:59AM +0100, Roman Zippel wrote:
> The current output looks like this:
> 
> config: ULTRIX_PARTITION
>   define_bool
>     default: y
>     dep: ((!PARTITION_ADVANCED?) && DECSTATION=y)
>   bool
>     prompt:   Ultrix partition table support
>     dep: PARTITION_ADVANCED?
>   help:
>   Say Y here if you would like to be able to read the hard disk
>   partition table format used by DEC (now Compaq) Ultrix machines.
>   Otherwise, say N.

I like this.  It's simple, its clean, and it keeps all the
information in one spot.  I think we can go a bit farther here
and add in a list of the .c files that enabling this feature
should add to the Makefile (per the current 
    obj-$(CONFIG_FOO)            += foo.o
stuff in the current Makefile).

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
