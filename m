Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132722AbRC2MKz>; Thu, 29 Mar 2001 07:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132723AbRC2MKe>; Thu, 29 Mar 2001 07:10:34 -0500
Received: from helena.mi.uni-erlangen.de ([131.188.103.20]:5772 "EHLO
	mi.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S132722AbRC2MK0>; Thu, 29 Mar 2001 07:10:26 -0500
Date: Thu, 29 Mar 2001 14:05:44 +0200 (MEST)
From: Walter Hofmann <snwahofm@mi.uni-erlangen.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: Jesse Pollard <jesse@cats-chateau.net>, Shawn Starr <spstarr@sh0n.net>,
   linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
In-Reply-To: <200103281440.IAA48398@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.GSO.3.96.1010329135819.12171A-100000@eumaios>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Mar 2001, Jesse Pollard wrote:

> By itself it doesn't - but if you also don't have user/group/world rw and
> don't own the file, you can't do anything to it.

This is all completely useless. Why not remove world rw permissions in the
first place. If the admin isn't even able to write a cron job that does
this, all help is lost.

> It's only there to reduce accidents. If you want to go full out,
> remove the symbols from the file.

Just as useless.

> Now, if ELF were to be modified, I'd just add a segment checksum
> for each segment, then put the checksum in the ELF header as well as
> in the/a segment header just to make things harder. At exec time a checksum
> verify could (expensive) be done on each segment. A reduced level could be
> done only on the data segment or text segment. This would at least force
> the virus to completly read the file to regenerate the checksum.

So? The virus will just redo the checksum. Sooner or later their will be a
routine to do this in libbfd and this all reduces to a single additional
line of code. 

> That change would even allow for signature checks of the checksum if the
> signature was stored somewhere else (system binaries/setuid binaries...).
> But only in a high risk environment. This could even be used for a scanner
> to detect ANY change to binaries (and fast too - signature check of checksums
> wouldn't require reading the entire file).

One sane way to do this is to store the sig on a ro medium and make the
kernel check the sig of every binary before it is run.

HOWEVER, this means no compilers will work, and you have to delete all
script languages like perl or python (or make all of them check the
signature).

Useless again, IMO.

> In any case, the problem is limited to one user, even if nothing is done.

Your best bet is to educate your users.

Walter

