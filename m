Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbRGQWXN>; Tue, 17 Jul 2001 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbRGQWWx>; Tue, 17 Jul 2001 18:22:53 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:19724 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267485AbRGQWWp>; Tue, 17 Jul 2001 18:22:45 -0400
Message-ID: <3B54BA7A.42B0E107@namesys.com>
Date: Wed, 18 Jul 2001 02:21:46 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Craig Soules <soules@happyplace.pdl.cmu.edu>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <Pine.LNX.3.96L.1010717180713.13980K-100000@happyplace.pdl.cmu.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Soules wrote:
> 
> On Wed, 18 Jul 2001, Hans Reiser wrote:
> > I take issue with the word "properly".  We have bastardized our FS design to do it.  NFS should not
> > be allowed to impose stable cookie maintenance on filesystems, it violates layering.  Simply
> > returning the last returned filename is so simple to code, much simpler than what we have to do to
> > cope with cookies.  Linux should fix the protocol for NFS, not ask Craig to screw over his FS
> > design.  Not that I think that will happen.....
> 
> Unfortunately to comply with NFSv2, the cookie cannot be larger than
> 32-bits.  I believe this oversight has been correct in later NFS versions.
> 
> I do agree that forcing the underlying fs to "fix" itself for NFS is the
> wrong solution. I can understand their desire to follow unix semantics
> (although I don't entirely agree with them), so until I think up a more
> palatable solution for the linux community, I will just keep my patches to
> myself :)
> 
> Craig

64 bits as in NFS v4 is still not large enough to hold a filename.  For practical reasons, ReiserFS
does what is needed to work with NFS, but what is needed bad design features, and any FS designer
who doesn't feel the need to get along with NFS should not have acceptance of bad design be made a
criterion for the acceptance of his patches.  Just let NFS not work for Craig's FS, what is the
problem with that?

Hans
