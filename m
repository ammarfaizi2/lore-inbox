Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161376AbWAST73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161376AbWAST73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161359AbWAST73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:59:29 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:62316 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161374AbWAST72 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:59:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kHXRO+5tKn/M78DhfxzAtBik9l4QMZNq+kW1VPcxwegDx0kyM2KAPq4OAP/J24t1izNJ4CitLGeGNFbqziuoXdNaiSI3EzF1CMoJr9zes40NpoFPzy9W/wiBhKAcmseK2VxVQDwkmFl8J4c59Hbr/uG5y+HoY5WN9Y6ue56U6PU=
Message-ID: <a44ae5cd0601191159y4801d6b6ld45785b7e7e356b8@mail.gmail.com>
Date: Thu, 19 Jan 2006 11:59:26 -0800
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] Error 2"
In-Reply-To: <200601191105.k0JB5sKN012313@typhaon.pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com>
	 <200601191105.k0JB5sKN012313@typhaon.pacific.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/06, David Luyer <david@luyer.net> wrote:
> On Wed, Jan 18, 2006 at 10:47:13PM -0800, Miles Lane wrote:
> > make all install modules modules_install
> > /bin/sh: -c: line 0: syntax error near unexpected token `('
> > /bin/sh: -c: line 0: `set -e; echo '  CHK
> > include/linux/version.h'; mkdir -p include/linux/;      if [ `echo -n
> > "2.6.16-rc1-git1 .file null .ident
> > GCC:(GNU)4.0.320060115(prerelease)(Ubuntu4.0.2-7ubuntu1) .section
> > .note.GNU-stack,,@progbits" | wc -c ` -gt 64 ]; then echo
> > '"2.6.16-rc1-git1 .file null .ident
> [...]
>
> Happens for me also (on latest snapshot).
>
> /dev/null is removed by this line in check-lxdialog.sh during a
> 'make menuconfig':
>
>    echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null
>
> This only happens if you don't have a libncursesw installed (not sure
> if it is compiler dependant as well).
>
> /dev/null being removed has many side-effects, this is just one of them.
>
> Obviously 'cd /dev; ./MAKEDEV null' will fix.  Oh, and fixing the script
> would be useful too ;-)

I checked and /dev/null exists.  I also have libncursesw5 installed.
Oddly, I rebooted and when I ran make, the build proceeded.  I quit
and ran "make menuconfig" again.  As you suggested, this did break
my build process as before.  I had to reboot in order to complete the
build process.  Any other possibilities?

Thanks!
        Miles
