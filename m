Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSGFUzD>; Sat, 6 Jul 2002 16:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSGFUzD>; Sat, 6 Jul 2002 16:55:03 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:38394 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S311749AbSGFUzB>; Sat, 6 Jul 2002 16:55:01 -0400
Date: Sat, 6 Jul 2002 13:56:54 -0700
From: Chris Wright <chris@wirex.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Chris Wright <chris@wirex.com>,
       Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
       Michael Kerrisk <m.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Status of capabilities?
Message-ID: <20020706135654.A25414@figure1.int.wirex.com>
Mail-Followup-To: Dax Kelson <dax@gurulabs.com>,
	Chris Wright <chris@wirex.com>,
	Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
	Michael Kerrisk <m.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
References: <1025157926.1652.35.camel@mentor> <200206271257.HAA61267@tomcat.admin.navo.hpc.mil> <20020627135422.B26112@figure1.int.wirex.com> <1025218353.3997.33.camel@mentor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1025218353.3997.33.camel@mentor>; from dax@gurulabs.com on Thu, Jun 27, 2002 at 04:52:33PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dax Kelson (dax@gurulabs.com) wrote:
> On Thu, 2002-06-27 at 14:54, Chris Wright wrote:
> > * Jesse Pollard (pollard@tomcat.admin.navo.hpc.mil) wrote:
> > > 
> > > Actually, I think most of that work has already been done by the Linux
> > > Security Module project (well, except #7).
> > 
> > The LSM project supports capabilities exactly as it appears in the
> > kernel right now.  The EA linkage is still missing.  Of course, we are
> > accepting patches ;-)
> 
> Has either lscap or chcap been written? I suppose not as that would
> require a consensus on how capabilities would be stored as a EA. 

You might take a look at the linux-privs stuff.  I believe it's pretty
out of date, but you can see where things left off.  Specifically, the
fcap parts.

> 
> That EA would need to be "special" and only be changeable by uid 0 (or
> CAP_CHFSCAP).

Actually, that would be CAP_SETFCAP as defined by the standard.

> So, has any of the below changed now that LSM has entered the picture?

No.  The EA bits are the important part.

> 1. Define how capabilities will be stored as a EA
> 2. Teach fs/exec.c to use the capabilities stored with the file
> 3. Write lscap(1)
> 4. Write chcap(1)
> 5. Audit/fix all SUID root binaries to be capabilities aware
> 6. Set appropriate capabilities with for each with chcap(1) and then:
>    # find / -type f -perm -4000 -user root -exec chmod u-s {} \;
> 7. Party and snicker in the general direction of that OS with the slogan
> "One remote hole in the default install, in nearly 6 years!"

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
