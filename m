Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131087AbRCGOID>; Wed, 7 Mar 2001 09:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbRCGOHy>; Wed, 7 Mar 2001 09:07:54 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:44039 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131087AbRCGOHn> convert rfc822-to-8bit; Wed, 7 Mar 2001 09:07:43 -0500
Message-Id: <200103071406.f27E6pO25638@aslan.scsiguy.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Jörn Nettingsmeier 
	<nettings@folkwang-hochschule.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver 
In-Reply-To: Your message of "Wed, 07 Mar 2001 12:48:30 +0100."
             <3AA6200E.8C398B2E@folkwang-hochschule.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 07 Mar 2001 07:06:51 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>hello justin !
>
>i have just tried to install the latest 2.4.3pre3 kernel with your
>driver.
>it failed with yacc: file not found.
>while i could install yacc, i have never had to use it before. i was
>assuming that the newer bison could do the same thing (which is what
>i have installed).
>so far, the kernel has not relied on yacc, which is why i'd like to
>ask you if it's possible to make it work with bison.

The assembler makefile doesn't reference yacc, but instead relies
on gmake's built in rules to figure out how to generate a .c from
a .y.  I'm somewhat surprised that bison doesn't create a link to
yacc or that gmake doesn't try to look for bison.

Oh well.  We'll just have to be more careful in how future patches
are generated so that the dependency between the generated firmware
files and the firmware source only triggers if you are actually
performing firmware development.  Trying to build this simple
assmebler on everyone's systems is turning out to be just too
hard.

--
Justin
