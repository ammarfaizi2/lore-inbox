Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313059AbSDCFaZ>; Wed, 3 Apr 2002 00:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSDCFaP>; Wed, 3 Apr 2002 00:30:15 -0500
Received: from violet.setuza.cz ([194.149.118.97]:62475 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S313059AbSDCF36>;
	Wed, 3 Apr 2002 00:29:58 -0500
Subject: Re: Question about 'Hidden' Directories in ext2
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0204021704360.6590-100000@rtlab.med.cornell.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Apr 2002 07:29:57 +0200
Message-Id: <1017811798.250.0.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-03 at 00:16, Calin A. Culianu wrote:
> 
> Ok, so some hackers broke into one of our boxes and set up an ftp site.
> They monopolized over 70gb of hard drive space with warez and porn.  We
> aren't really that upset about it, since we thought it was kind of funny.
> (Of course we don't like the idea that they are using out bandwidth and
> disk space, but we can easily remedy that).
> 
> Anyway, the weird thing is they created 2 directories, both of which were
> strangely hidden.  You can cd into them but you can't ls them.  I
> 
> /usr/lib/ypx and /usr/man/ypx were the two directories that contained both
> the ftp software and the ftp root.  When you are in /usr/man and you do an
> ls, you don't see the ypx directory (same when you are in /usr/lib).  The
> ls binary we got is right off the redhat cd so it shouldn't still be
> compromised by whatever rootkit was installed.
> 
> My question is this: can the data structures in ext2fs be somehow hacked
> so a directory can't appear in a listing but can be otherwise located for
> a stat or a chdir?  I should think no.. maybe we still haven't gotten rid
> of the rootkit...

Hi,

Andreas is right. If you're compromized, You should reinstall your
system.
We catched an atacker at work not long ago. They hadn't the time to
remove their cracking tools, so we were able to analyze them.
This led me to the conclusion not to use a standard distro ( amongst
other things ). The script they used analyzed which distro is in use,
and infected the apropriate places for all popular distributions.
Furtheron I wrote a module to bastillize the box, using exactly the
methods crackers are using ( an example is on phrack ). Oh ... yes, and
last but not least we modified some userspace progs and the kernel (
this task took me to this list ), and we have everything read-only ( tmp
and var on a fs mounted noexec,nosuid,nodev ).

Regards
Frank

BTW: Can anyone point me to a site on which I can find some info about
the usage ot the crypto patches?


