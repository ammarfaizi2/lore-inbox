Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135544AbRDXRD3>; Tue, 24 Apr 2001 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135549AbRDXRDX>; Tue, 24 Apr 2001 13:03:23 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:6565 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S135544AbRDXRDK>; Tue, 24 Apr 2001 13:03:10 -0400
Date: Tue, 24 Apr 2001 12:02:48 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104241702.MAA00717@tomcat.admin.navo.hpc.mil>
To: alan@lxorguk.ukuu.org.uk, cat@zip.com.au (CaT)
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <E14s57p-0002LM-00@the-village.bc.nu>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        mhaque@haque.net (Mohammad A. Haque),
        ttel5535@artax.karlin.mff.cuni.cz,
        mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> > 1. email -> sendmail
> > 2. sendmail figures out what it has to do with it. turns out it's deliver
> ...
> 
> > Now, in order for step 4 to be done safely, procmail should be running
> > as the user it's meant to deliver the mail for. for this to happen
> > sendmail needs to start it as that user in step 3 and to do that it
> > needs extra privs, above and beyond that of a normal user.
> 
> 	email -> sendmail
> 	sendmail 'its local' -> spool
> 
> user:
> 	get_mail | procmail
> 	mutt
> 
> The mail server doesnt need to run procmail. If you wanted to run mail batches
> through on a regular basis you can use cron for it, or leave a daemon running

And get_mail must have elevated privileges to search for the users mail...
or sendmail must have already switched user on reciept to put it in the
users inbox which also requires privleges...

And an additional daemon (owned by the user) is yet another attack point...

Cron could be used to batch message handling... as long as it runs before
the users quota is used up. This becomes the same as using IMAP or fetchmail
to download it.

It's much more efficent to process each mail as it arrives.

All this does is move the program that requires privileges to somewhere
else. It doesn't eliminate it.

Granted, sendmail could use a better implementation of a security model.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
