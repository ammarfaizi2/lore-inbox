Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRDSPjd>; Thu, 19 Apr 2001 11:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDSPjX>; Thu, 19 Apr 2001 11:39:23 -0400
Received: from stanis.onastick.net ([207.96.1.49]:2064 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S130466AbRDSPjT>; Thu, 19 Apr 2001 11:39:19 -0400
Date: Thu, 19 Apr 2001 11:38:54 -0400
From: Disconnect <dis@sigkill.net>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bug in serial.c
Message-ID: <20010419113854.D16472@sigkill.net>
In-Reply-To: <25369470B6F0D41194820002B328BDD27C8E@ATLOPS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25369470B6F0D41194820002B328BDD27C8E@ATLOPS>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Marc Karasek did have cause to say:

> 2) In 2.4.3 the console port using ttySX is broken.  It dumps fine to the
> terminal but when you get to a point of entering data (login, configuration
> scripts, etc) the terminal does not accept any input.  

Most gettys and such take a /dev/tty* argument, which has to be changed to
point to the serial port for a serial console. Config scripts (and
anything else) specifically using /dev/tty or /dev/console should work
fine, however. (I wouldn't recommend pointing a getty at /dev/console - we
had some issues on a headless server trying that. Easiest to point it at
/dev/ttyS0 or whatnot.)

> 
> So far I have been able to debug to the point where I see that the kernel is
> receiving the characters from the serial.c driver.  But it never echos them
> or does anything else with them.  I will continue to look into this at this
> end.  
> 
> I was also wondering if anyone else has seen this or if a patch is avail for
> this bug??
> 
> Marc Karasek
> Sr. Firmware Engineer
> iVivity Inc
> marc_karasek@ivivity.com  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---
   _.-=<Disconnect>=-._
|     dis@sigkill.net    | And Remember...
\  shawn@healthcite.com  / He who controls Purple controls the Universe..
 PGP Key given on Request  Or at least the Purple parts!

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
