Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136006AbRDVKAi>; Sun, 22 Apr 2001 06:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136008AbRDVKA2>; Sun, 22 Apr 2001 06:00:28 -0400
Received: from duba04h04-0.dplanet.ch ([212.35.36.38]:32268 "EHLO
	duba04h04-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S136007AbRDVKAV>; Sun, 22 Apr 2001 06:00:21 -0400
Message-ID: <3AE2B847.C4EE45E9@dplanet.ch>
Date: Sun, 22 Apr 2001 12:53:59 +0200
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Request for comment -- a better attribution 
 system
In-Reply-To: <E14r6oh-0004Zu-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Another is to be able to generate reports on exactly how much of the kernel
> > is in "Maintained" or "Supported" status.  I think it would be worth
> > making this change just so we could know that.
> 
> There is no correlation between claimed and actual levels of supportedness.
> There are drivers with no-one supporting them that are common and thus get
> fixed very rapidly for example.
> 
> I actually prefer MAINTAINERS because it breaks things down by area and reflects
> the actual maintainership and areas covered. Something that per file does not
> 

Question about patches you receive:
How many patch from Maintainer do you receive?
How many patch from non-Maintainer do you receive (for maintained code)?
How many patch from non-Maintainer do you receive (for non maintained
code)?
[I don't need absolute values (but only ratios) nor exact numbers, just
for make
me an idea]


IMHO the problem show in this thead is:
Where developers should send patches? To Linus/AC or to driver
maintainer?
ESR proposal enforces this last, but do all mainainers have always time
for linux
developement? Should the maintainers be professional? Should Linus/AC
reject
clean patches from non-maintainers? Do all maintainers read lkml?


I think the idea of ESR is nice for the normal .c codes. The
[Cc]onfig.in and
Makefile are a very special case, and I think after the inclusion of new
kbuild in linux kernel, the maintainement of these files will be not a
big
issue, so I will not discuss this special case.

When I find a bug in a file, I check at the top of the file to find who
is the
maintainer. Normally I found the address of maintainer, and I will use
this address. Thus there is already some duplicate address (but the
addresses
in MAINTAINER are sometime old, or missing).
I see ESR proposal as a clean up/standardization of the head of normal
files.
This is the case of developer that need to contact a maintainer .

The top MAINTAINER it is needed for the normal user that find a bug (and
that don't know the structure of kernel).

Thus my proposal: We implement the ESR proposal and we create a new
MAINTAINER file that will list some bugs ML (for each subsystem).
In this manner the life of not-developer user will be simplified and
maybe we receive some more bug report.
Alternativelly we can generate MAINTAINER from ESR's map headers.
In this case we should include this script in the Linus script to
automagically create the i386 defconfig.


BTW ESR's last threads show us some other problem in linux developement
style.
(or better: the inhomogenity of developement style of some part of
kernel),
and we should convince him that the newer subsystem (and arch) should be
really
developed as cathedral style (untill stabilization) or we will be
flooded by big
kernel patches every few days.


	giacomo


PS: reading again this email (and doing some additions), I see that we
cannot
standardize maintainers (nor ESR proposal nor in the actual
MAINTAINERS).
ESR proposal cannot give us the right solution. We should live with the
incomplete MAINTAINERS file and missing maintainers.

BTW also in Debian we have problems with MIA (and very busy)
maintainers,
but because we are free project, we should live with that (and no-files
could
give us a solution) [in Debian MIA file, here the Date files of ESR
proposal]

Thus ESR: If a maintainer did not reply to you (or if you don't find the
maintainer name), you will be the tmp_maintainer of such files.
Files could help us, but no so much to solve your (and maybe us future)
problems.


	giacomo
