Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWBVNhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWBVNhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWBVNhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:37:33 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:8392 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751276AbWBVNhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:37:32 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 22 Feb 2006 14:36:01 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] portable Makefiles (was: CD writing in future Linux 
 (stirring up a hornets' nest))
Message-ID: <43FC68C1.nailEC711MJAV@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <200602171502.20268.dhazelton@enter.net>
 <43F9D771.nail4AL36GWSG@burner>
 <200602201302.05347.dhazelton@enter.net>
 <43FAE10F.nailD121QL6LN@burner>
 <20060221101644.GA19643@merlin.emma.line.org>
 <43FAF2FA.nailD12BW90DH@burner>
 <20060221114625.GA29439@merlin.emma.line.org>
In-Reply-To: <20060221114625.GA29439@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > Thank you for proving that you are completely uninformed!
>
> You just proved your incapability to extract the meaning of five simple
> lines. If you're incapable to understand simple statements like these,
> shut your head.

You just did strengthen the impression you gave with your mail before....
although - after a long time - you at least did again make yourself busy
with the topic in a mail....

> The meaning is, just especially for you so you can excuse yourself, and
> in PowerPoint style to be easy on your time:
>
> - run Solaris' /usr/{ccs,xpg4}/bin/make
>   to find out if your Makefile is portable

Solaris make does not write useful error messages in case of non-portable 
makefiles.

> - run BSD's portable make (that's a proper name)
>   to find out if your Makefile is portable

BSD make may be portable (although I am sure that smake comppiles/runs
on much more platforms) but it is not POSIX compliant. The fact that a
makefile does not work with BSD make does not prove anything as only simpile
makefiles are handeled the same way as POSIX based make programs do.

After we fixed the bug with pattern macro expansions in FreeBSDs make,
it turned out that cc -o some/dir/to/file.o file.c is handled completely
different from UNIX make programs. This makes it impossible to use FreeBSD
make for e.g. the Schily makefilesystem.


> - testing real-world make programs with Makefiles will find out much
>   more reliably if non-portable constructs are used.

??? smake _is_ a real world make program and if you rate POSIX compliance
and portability, it will outstrip all other known make programs.


> Examples: smake -W -posix (version 1.2a34, the newest available) doesn't
> warn of include foo.d (works with said make tools, but isn't POSIX
> compliant), and doesn't warn of -include foo.d (works with smake, GNU
> make, BSD make, but not SUN make).

While smake is much closer to POSIX than e.g. GNU make (proof by looking at
#ifdefs related to DOS like OS <CR/NL> instead of just <NL> in the source code
and find that smake has no single exception for DOS in the parser while GNU
make still does not work correctly with all makefiles). But in a single point, 
the GNU make maintainers are correct:

	A POSIX make is not able to compile portable applications, so we
	need to make the make program portable and add features.

Smake does exactly this. It adds the needed features (see "man makefiles" &
"man makerules") from Sun ideas in 1986 and implements them in a portable way.
The needed features are pattern matching expansion and "include".

> This is pretty strong evidence that smake is insufficient as
> Makefile portability validator, which substantiates my recommendation to
> test real-world make(1) programs rather than smake to find out the
> portability characteristics.

The other make programs I know are worse then smake and they are usually not
portable themself. Note that I don't like to use the technology from the 1970s
as GNU "automake" does.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
