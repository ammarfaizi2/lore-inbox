Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbTAZWoz>; Sun, 26 Jan 2003 17:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTAZWoz>; Sun, 26 Jan 2003 17:44:55 -0500
Received: from [213.86.99.237] ([213.86.99.237]:6366 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267041AbTAZWoy>; Sun, 26 Jan 2003 17:44:54 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030126232839.GF394@kugai> 
References: <20030126232839.GF394@kugai>  <20030126220842.GB394@kugai> <20030123193540.GD13137@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu> <28922.1043617222@passion.cambridge.redhat.com> 
To: Christian Zander <zander@minion.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Jan 2003 22:46:39 +0000
Message-ID: <30455.1043621199@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zander@minion.de said:
> I am well aware of the documentation in Documentation/kbuild and know
> that kbuild is flexible enough to support customized CFLAGS. I didn't
> argue that. 

Ok, but why else would you want your own makefiles if that's not that you 
wanted them for?

> I can't follow your hostility in this matter; I didn't "come crying"
> to you when things broke in the past and I'm not crying now. Last time
> I checked, voicing concerns was a legitimate thing to do.

True, but in this case you are voicing concern about the potential breakage
of something which was always known to be bad practice, fragile and
unreliable.

Your expression of concern is noted, but with about as much sympathy as is 
granted to those who express concern because kernel headers which they were 
including from userspace have changed.

Yes, it breaks if you invent you own makefiles. We knew that. 
Don't Do That Then -- or if you must, then just deal with it breaking in 
the kernel-de-jour.

> The "broken and short-term solutions" are needed with any kernel that
> doesn't provide the module building support introduced with Linux 2.5,
> which will likely be the majority of kernels in use for quite a while,
> still.

'make -C $LINUXDIR SUBDIRS=$PWD modules' has worked for as long as I can
remember; it's not new in 2.5. It's _always_ been the only reliable way to 
get kernel modules to build with the correct options.

--
dwmw2


