Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTENUei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbTENUei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:34:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:8206 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262856AbTENUeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:34:36 -0400
Date: Wed, 14 May 2003 22:47:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jonathan Bastien-Filiatrault <Intuxicated_kdev@yahoo.ca>
Cc: mec@shout.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.69 Change to i386 Makefile to distinguish athlons.
Message-ID: <20030514204709.GA1002@mars.ravnborg.org>
Mail-Followup-To: Jonathan Bastien-Filiatrault <Intuxicated_kdev@yahoo.ca>,
	mec@shout.net, Linux Kernel <linux-kernel@vger.kernel.org>
References: <3EC29191.5030700@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC29191.5030700@yahoo.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 02:57:21PM -0400, Jonathan Bastien-Filiatrault wrote:
> It should succesfully set -march=athlon-<type> according to uname -p.
> 
> --- linux-2.5.69/arch/i386/Makefile.orig    2003-05-14 
> 13:37:19.000000000 -0400
> +++ linux-2.5.69/arch/i386/Makefile    2003-05-14 14:50:03.000000000 -0400
> @@ -23,7 +23,7 @@
> CFLAGS += -pipe
> 
> check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > 
> /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
> -
> +get_athlon_type = ${shell case `uname -p` in "* 4 *") echo 
> "athlon-4";;*XP*) echo "athlon-xp";;*MP*) echo "athlon-mp";;*) echo 
> "athlon";;esac}

This is broken.
You have no guarantee whatsoever that the kernel is being compiled
for the machine where you do the compilation.

	Sam
