Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161546AbWAMRdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161546AbWAMRdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161567AbWAMRdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:33:17 -0500
Received: from palakse.guam.net ([202.128.0.38]:45223 "EHLO palakse.guam.net")
	by vger.kernel.org with ESMTP id S1161546AbWAMRdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:33:16 -0500
From: "Michael D. Setzer II" <mikes@kuentos.guam.net>
To: Kalin KOZHUHAROV <kalin@thinrope.net>, linux-kernel@vger.kernel.org
Date: Sat, 14 Jan 2006 03:32:50 +1000
MIME-Version: 1.0
Subject: Re: Problem getting PCMCIA to compile in Kernel.
Message-ID: <43C870E2.4989.4EE3A9@mikes.kuentos.guam.net>
In-reply-to: <dq8l5t$fg0$1@sea.gmane.org>
References: <43C8252F.6483.C6B2A8@mikes.kuentos.guam.net>
X-PM-Encryptor: QDPGP, 4
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14 Jan 2006 at 1:40, Kalin KOZHUHAROV wrote:

To:             	linux-kernel@vger.kernel.org
From:           	Kalin KOZHUHAROV <kalin@thinrope.net>
Subject:        	Re: Problem getting PCMCIA to compile in Kernel.
Date sent:      	Sat, 14 Jan 2006 01:40:28 +0900

> Michael D. Setzer II wrote:
> > I've tried to set the PCMCIA options to Y in the kernel build, but get a 
> > message that something else is build as a modual, so these can not be 
> > changed to y.
> 
> How did you do that?
> 
> Use `make menuconfig` to configure kernel.
> 
> > I went to the .config file and replaced every =m to =y, and then 
> > ran make. The kernel then was built with no problem, but it reset all these 
> > option back to =m.
> > 
> > CONFIG_PCMCIA_AHA152X=m
> > CONFIG_PCMCIA_FDOMAIN=m
> > CONFIG_PCMCIA_NINJA_SCSI=m
> > CONFIG_PCMCIA_QLOGIC=m
> > CONFIG_PCMCIA_SYM53C500=m
> > CONFIG_I2C_STUB=m
> > 
> > I build kernels for G4L, and build everything directly into the kernel, but 
> > these do not seem to work, and I don't have an ideal why, since everything 
> > else is built in. So what am I missing. This is the 2.6.15 kernel. 
> 
> If you play with .config directly, run a `make oldconfig` after that.
> So, `make oldconfig && make && make` should always work.
> If you tired that ant it did NOT, please post your .config file (not
> compressed) here, or upload it to a website (somewhere).

I ran the make oldconfig, then make menuconfig, and when I try to change 
the settings, it gives this message.

This feature depends on another which has been configured as  a module.
As a result,  this feature will be built as a module.

I had manually edited the .config file, and changed all =m to =y, so there is 
nothing in the file that has the module setting but these.

I placed a copy of the .config file at the link below. 
http://www.guam.net/home/mikes/bzImagez.config

Only those items with the PCMCIA and I2C_STUB have the =m.

Thanks for the reply. I'm trying to make a kernel that will suppor the most 
hardware, and avoid conflict.

> 
> Kalin.
> 
> -- 
> |[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
> +-> http://ThinRope.net/ <-+
> |[ ______________________ ]|
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


+----------------------------------------------------------+
  Michael D. Setzer II -  Computer Science Instructor      
  Guam Community College  Computer Center                  
  mailto:mikes@kuentos.guam.net                            
  mailto:msetzerii@gmail.com
  http://www.guam.net/home/mikes
  Guam - Where America's Day Begins                        
+----------------------------------------------------------+

http://setiathome.berkeley.edu
Number of Seti Units Returned:  19,471
Processing time:  32 years, 290 days, 12 hours, 58 minutes
(Total Hours: 287,489)


BOINC Seti@Home Total Credits 264500.664176 


-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8 -- QDPGP 2.61c
Comment: http://community.wow.net/grt/qdpgp.html

iQA/AwUBQ8dXoyzGQcr/2AKZEQLA8gCfaxZfvwlTNSMkHkXIdrJq0OM/ia8AnAlT
5kUyXZofk9mXe+et5oyU/vqg
=qbg4
-----END PGP SIGNATURE-----

