Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSEENjC>; Sun, 5 May 2002 09:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSEENjB>; Sun, 5 May 2002 09:39:01 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:32252
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312296AbSEENjA>; Sun, 5 May 2002 09:39:00 -0400
Message-ID: <3CD535F3.1193069@eyal.emu.id.au>
Date: Sun, 05 May 2002 23:38:59 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8-aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa2
In-Reply-To: <4003.1020585881@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 05 May 2002 17:40:56 +1000,
> Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> >You are right, it is not the unresolved that caused it but the non
> >ELF objects in there (it used not to care before):
> >
> ># /sbin/depmod-2.4.15 -ae ; echo $?
> >depmod: /lib/modules/2.4.19-pre8-aa2/ksyms is not an ELF file
> >depmod: /lib/modules/2.4.19-pre8-aa2/soundconf is not an ELF file
> >1
> 
> All versions of depmod for 2.4 have always returned errors for invalid
> objects in /lib/modules, that check has not changed since modutils
> 2.4.0.  modutils has not changed, somebody is storing extra text files
> in /lib/modules without telling modutils.  Don't do that.
> 
> Who created the ksyms and soundconf files?

I do. Since I have many kernels built, my build script copies the
important bits into there. I have done this for many years now
(as can be seen by the ancient 'soundconf' still being copied)
without any problems. /lib/modules is the only per-kernel area
on my machine and it is the most natural place to keep these files.

The failure started showing up only later in 2.4, I do not remember
exactly when but it is many months ago now. The 'not an ELF' message
was non fatal until then. I was pretty much keeping up with the
modutils releases.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
