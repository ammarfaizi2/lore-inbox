Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSLBSnv>; Mon, 2 Dec 2002 13:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSLBSnv>; Mon, 2 Dec 2002 13:43:51 -0500
Received: from concepts-ict.concepts.nl ([213.197.30.68]:63644 "EHLO
	concepts-ict.nl") by vger.kernel.org with ESMTP id <S264822AbSLBSnm>;
	Mon, 2 Dec 2002 13:43:42 -0500
Subject: Re: [Mjpeg-developer] Got DC10plus working with 2.4.20rc4
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: trog@wincom.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3deb80db.5d70.0@wincom.net>
References: <3deb80db.5d70.0@wincom.net>
Content-Type: text/plain
Organization: 
Message-Id: <1038854960.3293.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 19:49:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,

On Sun, 2002-12-01 at 17:54, Dennis Grant wrote:
> 2) Building the current CVS (which doesn't seem to have been altered in months)

Uh, they're being worked on almost daily by me and Laurent. Just not the
stable branch, but rather the video4linux2 branch. The standard branch
just works(tm) and only gets bugfixes/compilefixes when needed.

> for the driver-zoran project from mjpeg.sourceforge.net produced modules that
> worked. A brief visual comparison between them and the .c files in the kernel
> source didn't reveal any differences more obvious than some kernel version #ifdefs
> in the driver-zoran versions of the drivers - they're the same code, or at least
> _very_ similar.

The (important) difference is in the saa7110 module, afaik. That makes
the kernel driver fail.

> 3) I had to build the bttv kernel driver as a module to get the i2c-old.o module
> built.

Not really, they're just there... The BTTV driver uses i2c-core and
i2c-algo-bit.

>    c) When you check the DC10+ option in make config, these dependancies are
> not being resolved, and one or more of them don't make it into the kernel when
> one attempts to compile DC10+ in monolithic

In-kernel is basically not supported. Just use modules.

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

