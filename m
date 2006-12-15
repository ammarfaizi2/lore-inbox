Return-Path: <linux-kernel-owner+w=401wt.eu-S1753018AbWLORab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbWLORab (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbWLORab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:30:31 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:39494 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbWLORaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:30:30 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 12:30:30 EST
Message-ID: <4582DA4D.70907@drzeus.cx>
Date: Fri, 15 Dec 2006 18:24:29 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: ext Frank Seidel <frank@kernalert.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/4] Add MMC Password Protection (lock/unlock) support
 V8: mmc_key_retention.diff
References: <20061213155531.1kpbmi3pk40kkoos@webmail.kernalert.de> <45815B3A.1010805@indt.org.br>
In-Reply-To: <45815B3A.1010805@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> The code was based on code presents at security/keys/user_defined.c. This is the reason of why the MMC PWD code was
> implemented using this returns types and others implementations.
> That file (user_defined.c) implements generic functions to handle keys inside the kernel, using the Kernel Key Retention
> Service. Maybe you can take a look there, :).
> That zap variable was used to expand the key payload when a new password exceeded a previous configured size. But the
> Kernel Key Retention Service has changed and that zap variable is not used on key_instantiate function implemented at
> user_defined.c, anymore. I'll update the MMC PWD code.
>
>   

Patches look ok, and I'll commit them once you send me this last fix.

> Yes. I believe sizeof is a compiler operation and it does not access the data pointed by that pointer, it access just
> the type of the pointer.
>
>   

Yes, sizeof() is compile time and completely safe in this regard.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

