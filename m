Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265144AbSJWR6n>; Wed, 23 Oct 2002 13:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265145AbSJWR6m>; Wed, 23 Oct 2002 13:58:42 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:2221 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265144AbSJWR6k>; Wed, 23 Oct 2002 13:58:40 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 23 Oct 2002 10:55:04 -0700 (PDT)
Subject: Re: One for the Security Guru's
In-Reply-To: <ap6idh$1pj$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.44.0210230954270.17668-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes someone who has root can get the effect of modules by patching
/dev/kmem directly so eliminating module support does not eliminate all
risk.

it does however eliminate the use of the rootkits that use kernel modules.

you need to decide if the advantages of useing modules are worth it for
your situation.

what do you compile into a kernel to make it 1.9M compressed? I suspect
that you could trim that down to fit a floppy for a rescue disk. In
addition you may want to consider making your rescue disk be a CDROM so
that you can not only fit a larger boot image, but you can also fit more
untilities to help you work on the system.

also there are a couple ways to make a CD bootable.

One way is to use the floppy image (I think it's called El Torito or
something like that)

In addition I have created bootable CD's with lilo and ext2 partitions. If
it's an IDE CDROM you can setup a CD to treat it like a read-only IDE
drive (or you used to be able to anyway, I haven't checked it since 2.2
days)

David Lang

On Wed, 23 Oct 2002, Henning P. Schmiedehausen wrote:

> Date: Wed, 23 Oct 2002 16:23:13 +0000 (UTC)
> From: Henning P. Schmiedehausen <hps@intermeta.de>
> To: linux-kernel@vger.kernel.org
> Newsgroups: hometree.linux.kernel
> Subject: Re: One for the Security Guru's
>
> "Robert L. Harris" <Robert.L.Harris@rdlg.net> writes:
>
> >  I'd like it from the guru's on exactly how bad a hole this really is
> >and if there is a method in the kernel that will prevent such exploits.
> >For example, if I disable CONFIG_MODVERSIONS is the kernel less likely
> >to accept a module we didn't build?  Are there plans to implement some
> >form of finger printing on modules down the road?
>
> You can get the same effect as a module with a kernel without any
> modules support compiled. There are even root kits out there which do
> exactly this.
>
> If you want a little more security, don't run a vendor kernel
> (sic!). Not because they're unsafe but because many rootkits have
> binary modules for some well known kernels (2.4.9-34 or 2.4.18-3 come
> to mind); clean up your systems (e.g. don't ever ever ever have a
> compiler and a development kit on an internet connected system. If you
> don't have a compiler, 80% of all root kits will not work or will
> simply not be able to build the process hiding stuff because it comes
> as C code). If you run 2.4.18-3-rerolled with MODVERSIONS off, lots of
> the kiddie root kits break.
>
> You can't get security by design. Ask the OpenBSD people who tried
> this and failed.
>
> You get security by installing your systems, administrating them
> (which means looking at logfiles, unusual activities), keeping your
> boxes up to date with vendor patches and by training your staff to be
> security aware. Read lists like Bugtraq. Invest time (and money!) in
> the security of the systems.
>
> If some consultant sets up a box and slaps a "this is safe" label on
> it, start being suspicious. I've seen more than my share of RedHat 5.x
> and 6.x boxes which were installed like this and then they called me
> 12 months later because the "so secure" boxes have been rooted...
>
> 	Regards
> 		Henning
>
>
> --
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
>
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
