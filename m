Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTJFPkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTJFPko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:40:44 -0400
Received: from covilha.procergs.com.br ([200.198.128.212]:53001 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S262273AbTJFPkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:40:43 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6-bk7: kernel freeze if try to change to console
References: <87d6db2gw0.fsf@retteb.casa>
	<16257.17952.546250.954616@gargle.gargle.HOWL>
	<87vfr2ttev.fsf@retteb.casa>
	<16257.33403.756457.433093@gargle.gargle.HOWL>
From: Otavio Salvador <otavio@debian.org>
Date: Mon, 06 Oct 2003 12:40:39 -0300
In-Reply-To: <16257.33403.756457.433093@gargle.gargle.HOWL> (Mikael
 Pettersson's message of "Mon, 6 Oct 2003 16:55:55 +0200")
Message-ID: <87ad8etlvs.fsf@retteb.casa>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Otavio Salvador writes:
>  > Mikael Pettersson <mikpe@csd.uu.se> writes:
>  > 
>  > > Otavio Salvador writes:
>  > >  > Folks,
>  > >  > 
>  > >  > I'm using kernel 2.6.0-test6-bk7 and have some problems. If I try to
>  > >  > change to console from X my system freeze. I'm including my .config
>  > >  > file bellow.
>  > >
>  > > I have a hunch but I need to see your boot dmesg log to confirm.
>  > > Please post it.
>  > 
>  > Hello,
>  > 
>  > Here is it.
>
> Ok now I'm confused. The .config you posted earlier stated that
> you had both UP_APIC and APM_DISPLAY_BLANK enabled. Your dmesg
> log indicates that you're running on a 1.6GHz Athlon-XP, but
> there's no mention of APIC anything in the dmesg log.

Yes. Was my last try to solve the problem removing the APIC and
solves.

> So either your Athlon has had its local APIC disabled, or you
> changed the .config to exclude UP_APIC.
>
> In any case, APM_DISPLAY_BLANK is known to sometimes lock up when it
> blanks the console (e.g., when X exists). This is because some graphics
> card BIOSen can't handle local APIC interrupts (e.g., the timer).
> The workaround is to disable either APM_DISPLAY_BLANK or UP_APIC.

Now is working nicely. I've disabled APIC and all working fine now.

Thanks by your help.

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
