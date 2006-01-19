Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWASJPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWASJPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWASJPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:15:52 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:31291 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932458AbWASJPv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:15:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=INPwq6P+amToi+Key2FNNYT60CSOWr0lHOKLTdeqCSKqs6xWksVRs2lM3hz4sV4kBRfbESKkV8J8zoCwD7fZz4/PPjuVyED0QZwu88/jtNrecw/+EL5dHS5KM2W5UIvtex/wBprA28j0xdxhS+e5zQ18DEH16lVXm/gBDKBRsRs=
Message-ID: <a44ae5cd0601190115y6f6e93a1y6b6b6284280259fd@mail.gmail.com>
Date: Thu, 19 Jan 2006 01:15:49 -0800
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] Error 2"
In-Reply-To: <20060119073509.GA8231@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com>
	 <20060119073509.GA8231@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jan 18, 2006 at 10:47:13PM -0800, Miles Lane wrote:
> > make all install modules modules_install
> > /bin/sh: -c: line 0: syntax error near unexpected token `('
> > /bin/sh: -c: line 0: `set -e; echo '  CHK
> > include/linux/version.h'; mkdir -p include/linux/;      if [ `echo -n
> > "2.6.16-rc1-git1 .file null .ident
> > GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> > .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo
> > '"2.6.16-rc1-git1 .file null .ident
> > GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> > .note.GNU-stack,,@progbits" exceeds 64 characters' >&2; exit 1; fi;
> > (echo \#define UTS_RELEASE \"2.6.16-rc1-git1 .file null .ident
> > GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> > .note.GNU-stack,,@progbits\"; echo \#define LINUX_VERSION_CODE `expr 2
> > \\* 65536 + 6 \\* 256 + 16`; echo '#define KERNEL_VERSION(a,b,c) (((a)
> > << 16) + ((b) << 8) + (c))'; ) < /usr/src/linux-2.6/Makefile >
> > include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp
> > -s include/linux/version.h include/linux/version.h.tmp; then rm -f
> > include/linux/version.h.tmp; else echo '  UPD
> > include/linux/version.h'; mv -f include/linux/version.h.tmp
> > include/linux/version.h; fi'
> > make: *** [include/linux/version.h] Error 2
> Do you have any file in your build directory named localversion* ?
> That would explain the loon line that includes
> ".file null .ident GCC: ..."
>
> Otherwise something else goes in and trigger the long localversion.
> The variable CONFIG_LOCALVERSION may also be set to a wrong value in
> your environment but this is unlikely.

I don't have any localversion* files in the build directory.
I do have .kernelrelease that contains:
"2.6.16-rc1-mm1 .file null .ident
GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
.note.GNU-stack,,@progbits"
I tried deleting it,  but it gets recreated.

I'm pretty frustrated.  I have built hundreds of kernels and have not
hit this problem before.

Any help is most appreciated!
          Miles
