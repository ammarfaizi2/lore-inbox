Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbTCJJtm>; Mon, 10 Mar 2003 04:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbTCJJtm>; Mon, 10 Mar 2003 04:49:42 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:57607 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261218AbTCJJtk>; Mon, 10 Mar 2003 04:49:40 -0500
Date: Mon, 10 Mar 2003 11:00:02 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig update
In-Reply-To: <20030309211518.GA18087@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0303101046590.5042-100000@serv>
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
 <20030309190103.GA1170@mars.ravnborg.org> <Pine.LNX.4.44.0303092028020.32518-100000@serv>
 <20030309193439.GA15837@mars.ravnborg.org> <Pine.LNX.4.44.0303092115310.32518-100000@serv>
 <20030309211518.GA18087@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Mar 2003, Sam Ravnborg wrote:

> $ make KBUILD_VERBOSE=0 defconfig

defconfig is special case (like all{yes,no,mod}config). They basically 
set all options to a new value and print out the new config.
oldconfig could be less verbose and actually there is already a less 
verbose mode. If you skip the oldconfig step, the config tool is called 
anyway and checks the configuration and only asks as necessary. The same 
mode could be used for oldconfig, but I didn't want to change the 
behaviour needlessly. OTOH for oldconfig it should be no problem to call 
conf with '-s' instead of '-o' for the KBUILD_VERBOSE=0 case.

>  				if (!p2) {
> -					fprintf(stderr, "%s:%d: invalid string found\n", name, lineno);
> +					fprintf(stderr, "%s:%d: error: invalid string found\n", name, lineno);
>  					exit(1);

Um, my gcc doesn't produce any "error:" prefix.

bye, Roman

