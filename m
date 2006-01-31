Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWAaNlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWAaNlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWAaNlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:41:25 -0500
Received: from mail.gmx.de ([213.165.64.21]:64917 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750820AbWAaNlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:41:24 -0500
X-Authenticated: #428038
Date: Tue, 31 Jan 2006 14:41:16 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060131134116.GA6791@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mj@ucw.cz, linux-kernel@vger.kernel.org, acahalan@gmail.com
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <mj+md-20060131.104748.24740.atrey@ucw.cz> <43DF65C8.nail3B41650J9@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DF65C8.nail3B41650J9@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[stripping Cc: list]

Joerg Schilling schrieb am 2006-01-31:

> Martin Mares <mj@ucw.cz> wrote:
> 
> > > What Linux does is to artificially prevent this view to been seen from outside the
> > > Linux kernel, or to avoid integrating a particular device into a unique SCSI
> > > driver system although it would be apropriate.
> >
> > How exactly does Linux prevent this???
> 
> By not treating ATAPI the same as all other SCSI devices.

Nonsense. cdrecord can access ATAPI devices, fix your libscg device
enumeration.

> > How do you perform -scanbus for TCP/IP? :-)
> 
> There are various programs that do that for you.
> You could e.g. send a ping to the broadcast address in order to find hosts
> that are on the local network.

Responding to broadcast ping, at least when outside the LAN, is
considered a security issue.

> > Scanning for all available CD burners is of course a nice feature, but
> > I don't think it should be implemented by asking all existing SCSI-like
> > devices if they are a CD burner (for example because there can be an
> > almost infinite number of them, given that you can do SCSI-over-IP
> > and other similar tricks). The problem of presenting devices to the
> 
> And while this kind of scanning works in case that you have all devices 
> integrated inside a single SCSI implementation, it does not work for ATAPI
> because someont artificially decided to exclude one single SCSI transport 
> from the global view.

You need to work around this anyhow because the already-released 2.6
kernels will not be going away in the next 2 - 3 years even if 2.6
were fixed today.

-- 
Matthias Andree
