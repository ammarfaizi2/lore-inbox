Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUBWP3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUBWP3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:29:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12152 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261928AbUBWP1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:27:49 -0500
Date: Mon, 23 Feb 2004 07:27:48 -0800 (PST)
From: Tigran Aivazian <tigran@veritas.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
cc: Ryan Underwood <nemesis@icequake.net>, <224355@bugs.debian.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: microcode, devfs: Wrong interface change in 2.4.25
In-Reply-To: <403A15E5.6010705@debian.org>
Message-ID: <Pine.GSO.4.44.0402230725590.8603-100000@south.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giacomo,

Thank you. Leave it with me and I'll verify what's going on in the
2.4.25 version thereof and correct it.

Kind regards
Tigran

On Mon, 23 Feb 2004, Giacomo A. Catenazzi wrote:

> Hello!
>
>  From the 2.4.25, devfs doesn't create anymore the microcode
> device in /dev/cpu/microcode (as expected from in devices.txt
> and LANANA) but in /dev/misc/microcode. The /dev/cpu/microcode
> path is also hardcoded also in microcode_ctl and distributions
> create only /dev/cpu/microcode.
>
> So last microcode patch (in 2.4.25) is wrong.
> You should add again the /dev/cpu/microcode support in devfs, so
> that the normal and stable interface is maintained (in stable
> kernel serie)
>
> ciao
> 	giacomo
>
>
>
> Ryan Underwood wrote:
>
> > On Mon, Feb 23, 2004 at 09:47:58AM +0100, Giacomo A. Catenazzi wrote:
> >
> >>>What I meant is that the name "/dev/misc/microcode" must be used instead
> >>>of "/dev/cpu/microcode", because the microcode driver in 2.4.25 no
> >>>longer registers with devfs.
> >>
> >>I don't undestand.
> >>Do you say that devfs will register only /dev/misc/microcode ?
> >
> >
> > No, the microcode driver only registers with misc.
> >
> >
> >>So if devfs will register misc/microcode, it is probably
> >>a kernel bug (interface should not change!) or a problem
> >>with LANANA (in this case I should change misc microcode
> >> in drivers, but after an update to 'makedev' package.
> >
> >
> > Examine microcode.c driver diff between 2.4.23 and 2.4.25 in the init
> > function.  The removed code is obvious.
> >
>

