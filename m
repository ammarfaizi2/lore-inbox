Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSJEOyo>; Sat, 5 Oct 2002 10:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262362AbSJEOyo>; Sat, 5 Oct 2002 10:54:44 -0400
Received: from zero.aec.at ([193.170.194.10]:15113 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262360AbSJEOyn>;
	Sat, 5 Oct 2002 10:54:43 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.suse.lists.linux.kernel>
	<p73adltqz9g.fsf@oldwotan.suse.de> <anm5vf$m6p$1@cesium.transmeta.com>
From: Andi Kleen <ak@muc.de>
Date: 05 Oct 2002 17:00:13 +0200
In-Reply-To: <anm5vf$m6p$1@cesium.transmeta.com>
Message-ID: <m3it0hexs2.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> > -
> > +		case TIOCGDEV:
> > +			return put_user (kdev_t_to_nr (real_tty->device), (unsigned int*) arg);
> 
> This is broken -- you're returning a dev_t as an unsigned int.  On
> i386 that means overwriting two bytes of userspace you shouldn't be,

The interface is defined as int, not as dev_t (see the ioctl defines)

I'm not aware of anybody proposing 64bit dev_t for the kernel, 
only 32bit dev_t, and the interface provides for that.

-Andi
