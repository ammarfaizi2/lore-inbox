Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSEQHIp>; Fri, 17 May 2002 03:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSEQHIo>; Fri, 17 May 2002 03:08:44 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57099
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315449AbSEQHIm>; Fri, 17 May 2002 03:08:42 -0400
Date: Fri, 17 May 2002 00:07:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Conway <nconway.list@ukaea.org.uk>
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020517070750.GD627@matchmail.com>
Mail-Followup-To: Neil Conway <nconway.list@ukaea.org.uk>,
	vda@port.imtp.ilyichevsk.odessa.ua,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Anton Altaparmakov <aia21@cantab.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <5.1.0.14.2.20020514202811.01fcc1d0@pop.cus.cam.ac.uk> <3CE22B2B.5080506@evision-ventures.com> <200205151138.g4FBcGY13110@Port.imtp.ilyichevsk.odessa.ua> <3CE24CB9.8DFC5821@ukaea.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 12:55:37PM +0100, Neil Conway wrote:
> You can (and must) safely "touch the cable" in between TCQ commands in
> the right circumstances.  You are therefore touching the cable while the
> hwgroup is busy, hence my suggestion that the flag we use to prevent
> touching the cable during DMA should be named something other than busy.
>

Ahh, but with TCQ the concept of busy changes.  The wire (simplified) is
only busy when the tags are being transfered, otherwise the cable is unused
unless the cable has been "locked" by one of the devices.
