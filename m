Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRB0OhS>; Tue, 27 Feb 2001 09:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbRB0OhJ>; Tue, 27 Feb 2001 09:37:09 -0500
Received: from 13dyn203.delft.casema.net ([212.64.76.203]:31501 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129464AbRB0Og5>; Tue, 27 Feb 2001 09:36:57 -0500
Message-Id: <200102271436.PAA13534@cave.bitwizard.nl>
Subject: Re: binfmt_script and ^M
In-Reply-To: <E14XkaQ-0003Sa-00@the-village.bc.nu> from Alan Cox at "Feb 27,
 2001 01:54:40 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 27 Feb 2001 15:36:40 +0100 (MET)
CC: Ivo Timmermans <irt@cistron.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > > > (\r\n), Linux 2.4.2 can't find an interpreter because it doesn't
> > > > recognize the \r.  The following patch should fix this (untested).
> > > 
> > > Fix the script. The kernel expects a specific format
> > 
> > For what reason?  Is it a standard to not allow it, or does it break
> > other things?
> 
> The line terminator is \n so if you have
> 
> #!/usr/bin/perl\r\n
> 
> Then the command to run is "/usr/bin/perl\r" - and \r is a valid file name
> component

Agreed. If you insist "fix" it with..... 

cd /usr/bin
ln -s perl perl\r

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
