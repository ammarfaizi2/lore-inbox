Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbULCT4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbULCT4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbULCTzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:55:25 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:17559 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262491AbULCTya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:54:30 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Why INSTALL_PATH is not /boot by default?
Date: Fri, 3 Dec 2004 20:57:54 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411160127.15471.blaisorblade_spam@yahoo.it> <20041121094308.GA7911@mars.ravnborg.org>
In-Reply-To: <20041121094308.GA7911@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412032057.54958.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 November 2004 10:43, Sam Ravnborg wrote:
> On Tue, Nov 16, 2004 at 01:27:15AM +0100, Blaisorblade wrote:
> > This line, in the main Makefile, is commented:
> >
> > export  INSTALL_PATH=/boot
> >
> > Why? It seems pointless, since almost everything has been for ages
> > requiring this settings, and distros' versions of installkernel have been
> > taking an empty INSTALL_PATH as meaning /boot for ages (for instance
> > Mandrake). It's maybe even mandated by the FHS (dunno).
> >
> > Is there any reason I'm missing?
>
> Changing this may have impact on default behaviour of some versions of
> installkernel.
> If /boot is ok for other than just i386 we can give it a try.
Sorry for not answering to this.

What I say is *yes*, let's try it.

However, I know that ia64 is different because I read that in Fedora 2 kernel 
RPM specs:

#
# IA64 wants to be different as usual.. sigh.
#
%ifarch ia64
%define image_install_path boot/efi/EFI/redhat
%else
%define image_install_path boot
%endif

that should be done with a "ARCH_DEFAULT_INSTALL_PATH" set by archs and the 
main Makefile taking it by default. (Or even without indirection).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
