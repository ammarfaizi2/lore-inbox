Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSFFUMV>; Thu, 6 Jun 2002 16:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317175AbSFFUMU>; Thu, 6 Jun 2002 16:12:20 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:17674 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S317171AbSFFUMU>; Thu, 6 Jun 2002 16:12:20 -0400
Message-Id: <200206062006.g56K6OX04392@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: David Brownell <david-b@pacbell.net>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [linux-usb-devel] Re: device model documentation 2/3
Date: Thu, 6 Jun 2002 22:00:16 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200206051253.g55Crs331876@fachschaft.cup.uni-muenchen.de> <20020602044907.A121@toy.ucw.cz> <3CFFB4CA.3020508@pacbell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ... though FWIW I missed seeing anything that showed how
> those API summaries would place constraints on allocating
> memory, so I didn't assume there could be any.

It specified that there would be no valid assumptions on the
order of devices woken up. Thus the devices that would be paged
to may still be sleaping. Indeed this situation will always arise
if you have more than one device that may be swapped to
or by (storage, network, bluetooth, ...)

So only GFP_NOIO until every every is awake.

	Regards
		Oliver
