Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267523AbSKQQa2>; Sun, 17 Nov 2002 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbSKQQa2>; Sun, 17 Nov 2002 11:30:28 -0500
Received: from fmr03.intel.com ([143.183.121.5]:14330 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267523AbSKQQa1>; Sun, 17 Nov 2002 11:30:27 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reserving "special" port numbers in the kernel ?
References: <uel9mbcyi.fsf@unix-os.sc.intel.com>
	<1037414638.21937.20.camel@irongate.swansea.linux.org.uk>
From: Arun Sharma <arun.sharma@intel.com>
Date: 17 Nov 2002 08:37:19 -0800
In-Reply-To: <1037414638.21937.20.camel@irongate.swansea.linux.org.uk>
Message-ID: <uu1ig9mps.fsf@unix-os.sc.intel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sat, 2002-11-16 at 00:00, Arun Sharma wrote:
> > One of the Intel server platforms has a magic port number (623) that
> > it uses for remote server management. However, neither the kernel nor
> > glibc are aware of this special port.
> 
> I can't find it in the IETF standards documents either.

It's been registered as a well known port:

http://www.iana.org/assignments/port-numbers

[..]

> 
> > Has anyone run into this or similar problems before ? Thoughts on
> > what's the right place to handle this issue ?
> 
> Run your remote management daemon from xinetd, it'll then get the port
> nice and early in the system runtime.

The thing that's unique about our situation is that the daemon in not
user level. It runs at hardware/firmware level, so that you can
remotely administer the machine even when software is malfunctioning.

        -Arun

