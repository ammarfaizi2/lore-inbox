Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269726AbRH0XOz>; Mon, 27 Aug 2001 19:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRH0XOp>; Mon, 27 Aug 2001 19:14:45 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:8971 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269726AbRH0XOj>;
	Mon, 27 Aug 2001 19:14:39 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ricky Beam <jfbeam@bluetopia.net>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Bug or feature? 
In-Reply-To: Your message of "Mon, 27 Aug 2001 18:10:05 -0400."
             <Pine.GSO.4.33.0108271736500.23852-100000@sweetums.bluetronic.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Aug 2001 09:14:45 +1000
Message-ID: <3237.998954085@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001 18:10:05 -0400 (EDT), 
Ricky Beam <jfbeam@bluetopia.net> wrote:
>  dep_tristate '  Sun Microsystems userflash support' CONFIG_MTD_SUN_UFLASH $CONFIG_SPARC64
>$CONFIG_SPARC64 is null and this doesn't appear to the shell function as an
>arg.  Thus, it's presented as a selectable (tho' not compilable) option.
>
>The same is visable for CONFIG_MTD_SA1100 and CONFIG_MTD_DC21285 (ARM).
>
>Options:
> 1) Don't select things that aren't in your machine/arch.
>    (Translation: "Live with it.")
> 2) Quote all the options.
>    (ewww.)
> 3) Fix the function(s).

None of the above.  Null config variables are treated as "don't care"
when the user really meant "only allow if this option is 'y'".  It is a
generic config problem with arch variables and I have a fix somewhere
in my backlog.  I will try to dig it out and send to AC.

