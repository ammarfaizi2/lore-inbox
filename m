Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281938AbRKURf4>; Wed, 21 Nov 2001 12:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281937AbRKURfq>; Wed, 21 Nov 2001 12:35:46 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:32519 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S281934AbRKURfb>;
	Wed, 21 Nov 2001 12:35:31 -0500
Message-Id: <200111211853.NAA03050@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@suse.cz>
cc: Adam Feuer <adamf@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Swsusp mailing list <swsusp@lister.fornax.hu>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Gabor Kuti <seasons@falcon.sch.bme.hu>
Subject: Re: [swsusp] Re: swsusp for 2.4.14 
In-Reply-To: Your message of "Wed, 21 Nov 2001 16:46:20 +0100."
             <20011121164620.D31379@atrey.karlin.mff.cuni.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Nov 2001 13:53:13 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz said:
> Yep, I'd like to see it. [The way uml is setup with one uml kernel
> running in *many* real processes, saving/restoring cpu state is not
> going to be easy.]

It won't be horrible.  You have to recreate all the processes (and getting
their address spaces mapped correctly should be easy) and get them all
ptraced by the tracing thread.  UML processes which are CLONE_VM are also
CLONE_VM on the host, so that will take a little bit of care.

Devices will need to be reopened as well.

				Jeff

