Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSD0UE5>; Sat, 27 Apr 2002 16:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSD0UEy>; Sat, 27 Apr 2002 16:04:54 -0400
Received: from gjs.xs4all.nl ([213.84.2.78]:23561 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S314446AbSD0UEJ>;
	Sat, 27 Apr 2002 16:04:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: GertJan Spoelman <kl@gjs.cc>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: Microcode update driver
Date: Sat, 27 Apr 2002 22:04:06 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204272141010.2833-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204272204.06592.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 April 2002 21:42, Roy Sigurd Karlsbakk wrote:
> On Sat, 27 Apr 2002, Matthew M wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Saturday 27 April 2002 7:57 pm, Roy Sigurd Karlsbakk wrote:
> > > Sorry if this is a FAQ, but where's the microcode.dat supposed to be
> > > placed? I can't find any information about that in the doc.
> >
> > /usr/share/misc/microcode.dat
>
> hm... but... Isn't the microcode update being done during kernel boot?
> I rarely have a system set up with /usr on the same fs as /

On my system it lives in /etc, but you can place it anywhere you want, see the 
part below which I copied from the microcode README

***************************************************************************
>>> updating every system boot
***************************************************************************

A simple script has been included for systems to apply the microcode
update on boot. The script is a good illustration on how to use the
utility but it may be useful to run through some basic usage.

Without using the provided startup script, to update your microcode and
free the internal buffer on every system boot you'll need to add a line
like the following to /etc/rc.d/rc.local (where prefix indicates the
location of the binary)

prefix/microcode_ctl -iu

or to specify another microcode file

prefix/microcode_ctl -if /etc/microcode.dat

Simple as that. Problems? Contact either myself at simon@veritas.com or
Tigran at tigran@veritas.com


