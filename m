Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316619AbSE1OaV>; Tue, 28 May 2002 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316620AbSE1OaU>; Tue, 28 May 2002 10:30:20 -0400
Received: from kim.it.uu.se ([130.238.12.178]:8838 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S316619AbSE1OaT>;
	Tue, 28 May 2002 10:30:19 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15603.38007.42661.75173@kim.it.uu.se>
Date: Tue, 28 May 2002 16:30:15 +0200
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Miles Bader <miles@gnu.org>, Keith Owens <kaos@ocs.com.au>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
In-Reply-To: <20020528140322.GA6320@werewolf.able.es>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon writes:
 > Problem is that named initializers '.xx =' are ISO C99, so problably they
 > are not supported in gcc till 3.0...the old way is working with older
 > compilers.

"probably"? Why not check the facts. 2.95.3 implements ".name ="
initialisers, and 2.95.3 is also listed in 2.4.18's Documentation/Changes
as the oldest acceptable compiler.

I agree with Keith that we really should prefer standard C solutions
over gcc-specific hacks _when_they_exist_.

Also note that gcc is no longer the only compiler able to compile the
kernel. Intel claims that their icc6 compiler has correctly compiled 2.4.18
with only minor tweaks needed. They do implement inline asm() nowadays, but
alas not &&label and computed gotos.

/Mikael
