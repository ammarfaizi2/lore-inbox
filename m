Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132789AbRC2RMd>; Thu, 29 Mar 2001 12:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132790AbRC2RMX>; Thu, 29 Mar 2001 12:12:23 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:26711 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132789AbRC2RMO>; Thu, 29 Mar 2001 12:12:14 -0500
Date: Thu, 29 Mar 2001 11:10:05 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103291710.LAA69167@tomcat.admin.navo.hpc.mil>
To: snwahofm@mi.uni-erlangen.de,
   Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walter Hofmann <snwahofm@mi.uni-erlangen.de>:
> On Wed, 28 Mar 2001, Jesse Pollard wrote:
[snip]
> > Now, if ELF were to be modified, I'd just add a segment checksum
> > for each segment, then put the checksum in the ELF header as well as
> > in the/a segment header just to make things harder. At exec time a checksum
> > verify could (expensive) be done on each segment. A reduced level could be
> > done only on the data segment or text segment. This would at least force
> > the virus to completly read the file to regenerate the checksum.
> 
> So? The virus will just redo the checksum. Sooner or later their will be a
> routine to do this in libbfd and this all reduces to a single additional
> line of code. 

true.

> > That change would even allow for signature checks of the checksum if the
> > signature was stored somewhere else (system binaries/setuid binaries...).
> > But only in a high risk environment. This could even be used for a scanner
> > to detect ANY change to binaries (and fast too - signature check of checksums
> > wouldn't require reading the entire file).
> 
> One sane way to do this is to store the sig on a ro medium and make the
> kernel check the sig of every binary before it is run.

Only for trusted binaries. (extreme paranoia now).
 
> HOWEVER, this means no compilers will work, and you have to delete all
> script languages like perl or python (or make all of them check the
> signature).

Compilers should work normally, the link phase is what would generate
the checksums, though if each object file contained a checksum for the
segment then the interpreters/dynamic loaders would have the choice.

The only applications I see as really needing to check such signatures
are those using PAM. These should do it anyway. The dynamic linking programs
should do so only if they are configured to do so.

> Useless again, IMO.
> 
> > In any case, the problem is limited to one user, even if nothing is done.
> 
> Your best bet is to educate your users.

User eduation is a reasonable substitute as long as they can be directed
to follow the rules.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
