Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268837AbRIEJFo>; Wed, 5 Sep 2001 05:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268714AbRIEJFf>; Wed, 5 Sep 2001 05:05:35 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:9484 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S268837AbRIEJF0>; Wed, 5 Sep 2001 05:05:26 -0400
Message-ID: <3B95EA8F.93B27304@t-online.de>
Date: Wed, 05 Sep 2001 11:04:15 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Zaplinski <o.zaplinski@mediascape.de>
CC: joe.mathewson@btinternet.com, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors
In-Reply-To: <200109050621.f856LAK00824@ambassador.mathewson.int> <3B95DB22.866EDCA3@mediascape.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Zaplinski schrieb:
> 
> Joseph Mathewson wrote:
> >
> > I've just woken up this morning to find my internet gateway machine only
> > responding to pings, and on giving it a keyboard & monitor, a load of
> >
> > scsi0:0:1:0: Attempting to queue an ABORT message
> > scsi0:0:1:0: Cmd aborted from QINFIFO
> > aic7xxx_abort returns 8194
> >
> > errors.
> [...]
> 
> /me too. I had this while booting 2.4.9 with a fresh installed SCSI card
> (AHA2940) + harddisk. What worked for me was to compile the kernel with the
> old Adaptec driver, so it's a driver issue.
> 
> Olaf

Hello...

I had this effect too here (RH7.1, Kernel 2.4.3), but i put it on a
wrong termination of the LVD Bus...be careful if you have LVD-Drives
with a "Termination"-Jumper...(e.g. IBM DGHS18V)...this Termination is
only usable if you use the drive as Single Ended SCSI-UW, *not* if you
use the drive i a true LVD-environment !

I learnt this the hard way, because i used this "Termination"-jumper and
the system bootet without problems and ran about 2 weeks...then the
above errors occured, followed by system crashes....after reading the
original ibm-docs, and not the oem-reseller-crap, the reason was clear.

Th second thing i noticed was, that the value for "Maximum Number of TCQ
Commands per Device" is per default on 255, but wirt my system the
driver always complained, that he could only use 64 ("locked on
64")...so i decided to switch to 32 and not to let him auto-detect the
max. value...since then i had no problems at all...

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
