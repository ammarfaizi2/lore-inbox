Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312048AbSCQO44>; Sun, 17 Mar 2002 09:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312047AbSCQO4q>; Sun, 17 Mar 2002 09:56:46 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:54535 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312042AbSCQO4k>; Sun, 17 Mar 2002 09:56:40 -0500
Date: Sun, 17 Mar 2002 15:56:40 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020317145640.GA29943@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0203171505280.27987-100000@phobos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0203171505280.27987-100000@phobos>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is easier for application writers to code:
> 
> [...]
> #ifdef HAVE_FADVISE
> 	(void)fadvise(fd, FADV_STREAMING);
> #endif
> [...]
> 
> Than to have a forest of #ifdefs to determine which O_* flags are
> supported. After all, we still want our programs to run under Solaris. :-)

#ifndef O_STREAMING
#define O_STREAMING 0
#endif
(and then just use the flag in open)

is still better - it can be done in a header somewhere, once for all opens.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
