Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbRGPSoC>; Mon, 16 Jul 2001 14:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267660AbRGPSnw>; Mon, 16 Jul 2001 14:43:52 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:42507 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S267654AbRGPSng>; Mon, 16 Jul 2001 14:43:36 -0400
Message-ID: <3B533578.A4B6C25F@damncats.org>
Date: Mon, 16 Jul 2001 14:42:00 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Hartmann <jhartmann@valinux.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu> <3B532BB7.1050300@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Hartmann wrote:
> Actually I have something like this pretty much working.  Unfortunately
> I was working on a project full time during the 4.1.0 release.  With the
> addition of this code, the old modules will coexist with newer modules.
> Basically the newer modules will have their version numbers appended to
> their names, this way a user can build all the drm modules, and things
> will just work.  Hopefully we can get a 4.1.1 release out soon which
> will do this.  This will make the 4.0 -> 4.1 have to be a compile time
> decision, but 4.1 -> 4.1.1 and higher will just coexist with each
> other.  I'm currently working out integrating this into the kernel
> build, and I should hopefully have a patch for Linus and Alan soon.

Would it not be a bit more robust to have a wrapper module that pulls in
the correct one on demand? In other words, for the radeon, you would
still have the radeon.o module, but it would determine which child
module to load depending on the version of X that is requesting it. Thus
XFree86 would not require any changes and the backwards compatibility
would be maintained invisibly.

John
