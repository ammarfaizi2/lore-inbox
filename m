Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271108AbRIVObA>; Sat, 22 Sep 2001 10:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271278AbRIVOav>; Sat, 22 Sep 2001 10:30:51 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:35598 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S271108AbRIVOaf>; Sat, 22 Sep 2001 10:30:35 -0400
Date: Sat, 22 Sep 2001 10:31:00 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Whats in the wings for 2.5 (when it opens)
Message-ID: <20010922103100.C9352@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010921155806.B8188@mueller.datastacks.com> <17588.1001127560@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17588.1001127560@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Sep 22, 2001 at 12:59:20PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 22/09/01 12:59 +1000 - Keith Owens:
> On Fri, 21 Sep 2001 15:58:06 -0400, 
> Crutcher Dunnavant <crutcher@datastacks.com> wrote:
> >A cleaner handling of module parameters/cmd line options.
> 
> That comes out as a side effect of kernel build 2.5, every object gets
> -DKBUILD_OBJECT to define the name it is known by.  From
> Documentation/kbuild/kbuild-2.5.
> 
>       -DKBUILD_OBJECT=module, the name of the module the object is
>         linked into, without the trailing '.o' and without any paths.
>         If the object is a free standing module or is linked into
>         vmlinux then the "module" name is the object itself.
>         Automatically generated.
> 
> Post kbuild 2.5 I will be writing a generic parameter/command line
> interface so you can insmod foo bar=99 or boot with foo.bar=99.  You
> will even be able to boot with foo.bar=99 when foo is a module, insmod
> will use the command line as a default set of values.

Well, that certainly is clean. How deep does it go? For instance, can
we you define it as:

	foo.bar.baz.bat.quux=99 -> mod 'foo.bar.baz.bat', parm 'quux'

so we get naming schemes like:

	net.3com.3c501.i=5

This would help much with keeping some of the namespaces cleaner. Do you
want any help with this?

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
