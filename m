Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272721AbRIGPfb>; Fri, 7 Sep 2001 11:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272716AbRIGPfW>; Fri, 7 Sep 2001 11:35:22 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:115 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S272719AbRIGPfL>; Fri, 7 Sep 2001 11:35:11 -0400
Date: Fri, 7 Sep 2001 10:34:12 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200109071534.KAA90220@tomcat.admin.navo.hpc.mil>
To: lk@tantalophile.demon.co.uk,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
Cc: kubla@sciobyte.de, joe@mathewson.co.uk, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk>:
> Jesse Pollard wrote:
> > > Kerberos won't help either - The only parts of NFS that were kerberized
> > > was the initial mount. Everything else uses filehandles/UDP. Encryption
> > > doesn't help either - slows the entire network down too much.
> > 
> > I disagree! First of all you can always use NFS over TCP, so much for
> > "every thing else uses filehandles/UDP". (No that this improves security,
> > but it can improve reliability!)
> 
> It can improve security if you use NFS over TCP over SSL...
> 
> That may be easier to configure than IPSec in some environments.

I've never seen that used. I assume the procedure is something like:

1. login on client (requires home directory be local)
2. ssh to server (local window for password)
3. user mode mount to another directory (assuming not mounting working
   directory - marked busy, though that might be allowed)
4. use another window for local usage.

	mountd port has to be redirected
	nfsd port(s) have to be redirected (I think, might not apply to server)
	biod port(s) have to be redirected
	lockd port(s) have to be redirected (unless nolocking)
	statd port(s) have to be redirected (not sure)

And only a single user per host (not unreasonable).

Would it also work for windows/Macs?

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
