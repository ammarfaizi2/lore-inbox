Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131031AbRCGPmJ>; Wed, 7 Mar 2001 10:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbRCGPl7>; Wed, 7 Mar 2001 10:41:59 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:516 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131031AbRCGPlu>; Wed, 7 Mar 2001 10:41:50 -0500
Message-ID: <3AA6576D.81501D0@folkwang-hochschule.de>
Date: Wed, 07 Mar 2001 16:44:45 +0100
From: Jörn Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver
In-Reply-To: <200103071406.f27E6pO25638@aslan.scsiguy.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >hello justin !
> >
> >i have just tried to install the latest 2.4.3pre3 kernel with your
> >driver.
> >it failed with yacc: file not found.
> >while i could install yacc, i have never had to use it before. i was
> >assuming that the newer bison could do the same thing (which is what
> >i have installed).
> >so far, the kernel has not relied on yacc, which is why i'd like to
> >ask you if it's possible to make it work with bison.
> 
> The assembler makefile doesn't reference yacc, but instead relies
> on gmake's built in rules to figure out how to generate a .c from
> a .y.  I'm somewhat surprised that bison doesn't create a link to
> yacc or that gmake doesn't try to look for bison.
> 
> Oh well.  We'll just have to be more careful in how future patches
> are generated so that the dependency between the generated firmware
> files and the firmware source only triggers if you are actually
> performing firmware development.  Trying to build this simple
> assmebler on everyone's systems is turning out to be just too
> hard.

i might also be SuSE 7.1 related, since this was the first kernel i
compiled on the new distro.
but since the problem arose only with the new aic driver, i thought
it might be that you had a slightly different development
environment...?

anyway, robbert muller sent me the following simple workaround:


<quote>
Just create a shell script called yacc with the following content
-------------------
#!/bin/sh
bison --yacc $*
-------------------
i ran into the same problem with a school proiject here yesterday
</quote>


regards,

jörn


-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://www.folkwang-hochschule.de/~nettings/
