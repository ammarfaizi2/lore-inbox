Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312263AbSCRI6f>; Mon, 18 Mar 2002 03:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312258AbSCRI6R>; Mon, 18 Mar 2002 03:58:17 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:31500 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312253AbSCRI6L>; Mon, 18 Mar 2002 03:58:11 -0500
Date: Mon, 18 Mar 2002 09:58:11 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020318085811.GA21981@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020317190303.03289ec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020318000057.051d30e0@pop.cus.cam.ac.uk> <a73ujs$5mc$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Followup to:  <5.1.0.14.2.20020318000057.051d30e0@pop.cus.cam.ac.uk>
> By author:    Anton Altaparmakov <aia21@cam.ac.uk>
> In newsgroup: linux.dev.fs.devel
> > 
> > Ok, so basically we want both fadvise() and open(2) semantics, with the 
> > open(2) being a superset of the fadvise() capabilities (some things no 
> > longer make sense to be specified once the file is open). They can of 
> > course both be calling the same common helpers inside the kernel...
> > 
> 
> If they're open() flags, they should probably be controlled with
> fcntl() rather than with a new system call.

Then posix_fadvise interface can be implemented in libc using fcntl.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
