Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTAZVUm>; Sun, 26 Jan 2003 16:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbTAZVUm>; Sun, 26 Jan 2003 16:20:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:47632 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266996AbTAZVUk>;
	Sun, 26 Jan 2003 16:20:40 -0500
Date: Sun, 26 Jan 2003 22:29:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christian Zander <zander@minion.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126212950.GA6334@mars.ravnborg.org>
Mail-Followup-To: Christian Zander <zander@minion.de>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Mark Fasheh <mark.fasheh@oracle.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20030123193540.GD13137@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu> <20030126220842.GB394@kugai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030126220842.GB394@kugai>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 11:08:42PM +0100, Christian Zander wrote:
> External projects may not want to use the build flags unchanged, they
> may have good reasons for using their own. It seems sensible to make
> the kernel build system available to those who wish to use it, but it
> should be optional rather than mandatory. In this specific case, there
> is no technical reason to require the use of kbuild.

Judging on the number of people that got bid by the mach- include changes,
I conclude that we better ask people to use kbuild.

The whole issues boils down to the following options:
1) The "kernel-headers" package shall be extended to include the vital
part of kbuild
2) To develop modules you need the full kernel src
3) Do-it-yourself makefiles

Can we agree on that - and take the discussion from there?

In 1) and 2) you have total freedom to change options etc.
Several architectures filter out generic options they dislike.
Adding extra options is supported by kbuild (EXTRA_CFLAGS).

In 3) you have all possibilities to screw up things. You would probarly
argue you have full flexibility.
But then I wonder what kind of flexibility you need for your module, that
is not needed for all the modules included in the kernel?
To take your argument and turn it around:
What technical reasons are there to avoid kbuild?

Please realise that you will be hit by changes in include paths,
compiler options etc.
That is visible in the number of mails seen on lkml the last couple of
months.

	Sam
