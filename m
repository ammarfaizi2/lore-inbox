Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281948AbRKUSct>; Wed, 21 Nov 2001 13:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281946AbRKUScj>; Wed, 21 Nov 2001 13:32:39 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:38275 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281451AbRKUScT>; Wed, 21 Nov 2001 13:32:19 -0500
Message-ID: <002401c172ba$b46bed20$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: <arjan@fenrus.demon.nl>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 11:31:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: <arjan@fenrus.demon.nl>
To: "Jeff Merkey" <jmerkey@timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 21, 2001 12:49 AM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


> In article <003401c1725a$975ad4e0$f5976dcf@nwfs> you wrote:
>
> > OK.  Cool.  Now we are making progress.  I think this is a nasty
problem.
> > There are numerous RPMs that will build against the kernel tree and be
> > busted.  I would expect an rpm -ba on your DEFAULT kernel in Redhat with
> > the sources contained in the kernel.rpm files to also be broken unless
> > someone has done this.
>
> That's why Red Hat ships the kernel-source RPM; you can build external
> modules against that and it has the "make dep" information for all kernels
> Red Hat ships for that platform (with a smart "if" that selects the
> currently running one)........... But note the word "external". You build
in
> another directory and don't touch the original .config file or tree......
> Unless you need core changes, that's perfectly possible for almost all
> modules....
>

I would anticipate seeing this problem with their kernel source RPM.  In
fact, I do,
you have to do a make distclean before you can use it because of the way
their rpm
script munges all the versioned trees into a tmp area during RPM creation.
There's only
one source tree (usually the last one they built) and lots of binary rpm
versions from the
one tree (i.e. i386, i686, etc.).

Jeff

> Greetings,
>     Arjan van de Ven

