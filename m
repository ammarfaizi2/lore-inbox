Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbRF3HZo>; Sat, 30 Jun 2001 03:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbRF3HZe>; Sat, 30 Jun 2001 03:25:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18446 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264856AbRF3HZP>; Sat, 30 Jun 2001 03:25:15 -0400
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
To: adam@yggdrasil.com (Adam J. Richter)
Date: Sat, 30 Jun 2001 08:23:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <200106300440.VAA14185@adam.yggdrasil.com> from "Adam J. Richter" at Jun 29, 2001 09:40:12 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15GF6l-0001gx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Argh!  I just accidentally sent and older version of my
> patch.  Here is the current version.  Sorry about that.

This just breaks stuff

> +for var in $(cat arch/*/config.in |
> +	     egrep -w -v '^[ 	]*int' |
> +             tr '   $"' '\n\n\n' |
> +	     egrep '^CONFIG_[A-Z0-9_]*$' |
> +	     sort -u) ; do
> +	define_bool "$var" "n"
> +done
> +set -f
>  

You've changed the entire semantics of dep_tristate by doing this

