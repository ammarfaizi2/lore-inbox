Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270474AbRHHMbv>; Wed, 8 Aug 2001 08:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270478AbRHHMbl>; Wed, 8 Aug 2001 08:31:41 -0400
Received: from [204.222.179.33] ([204.222.179.33]:15672 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S270475AbRHHMbb>; Wed, 8 Aug 2001 08:31:31 -0400
Date: Wed, 8 Aug 2001 07:31:02 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200108081231.HAA69953@tomcat.admin.navo.hpc.mil>
To: mdharm-kernel@one-eyed-alien.net, Jesse Pollard <jesse@cats-chateau.net>
Subject: Re: using mount from SUID scripts?
Cc: Keith Owens <kaos@ocs.com.au>,
        Kernel Developer List <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> Unfortunately, the snippit of code here doesn't do the job... after the
> first two lines, the UID is unchanged, while the EUID is still 0 (root).  I
> used system "/usr/bin/id" to verify this.  /bin/mount is still complaining.
> 
> Oh, wait... $> is effective and $< is real.  So that first line should be
> ($r, $e) =3D ($<, $>); -- this makes everything happy!

drat... I thought I had that right...

Also the last line should be swapped too:

	($r, $e) = ($<, $>);
	$< =3D $e;
	<<<do stuff>>>
	($<, $>) = ($r,$e);

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
