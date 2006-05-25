Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWEYAzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWEYAzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWEYAzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:55:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:20883 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964794AbWEYAzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:55:35 -0400
Message-ID: <4475007F.7020403@garzik.org>
Date: Wed, 24 May 2006 20:55:27 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <200605232338.54177.dhazelton@enter.net>	 <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>	 <200605240017.45039.dhazelton@enter.net>	 <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>	 <9e4733910605240827w309c4dc7of42ea2def10960c9@mail.gmail.com>	 <21d7e9970605241618x7eaeb010h60817b5ca944acd9@mail.gmail.com> <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
In-Reply-To: <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> I do stand by my opinion that building a driver bus so that three
> independent drivers (fbdev, DRM, XAA/EXA) can simultaneously multitask
> on a single piece of hardware is not a good design. It is a political
> solution, not a technical one.

Strongly agreed, there.  There should be ONE hardware driver for a piece 
of hardware.  The core hardware driver should register with various 
subsystems, and use the appropriate common code libraries from there.

Just like all other Linux drivers do...

	Jeff


