Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbTBKG7F>; Tue, 11 Feb 2003 01:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbTBKG7E>; Tue, 11 Feb 2003 01:59:04 -0500
Received: from angband.namesys.com ([212.16.7.85]:60034 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265568AbTBKG7E>; Tue, 11 Feb 2003 01:59:04 -0500
Date: Tue, 11 Feb 2003 10:08:47 +0300
From: Oleg Drokin <green@namesys.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60
Message-ID: <20030211100847.B5850@namesys.com>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 10, 2003 at 11:08:28AM -0800, Linus Torvalds wrote:

> Networking, USB, SCSI, ALSA, ACPI, and various architecture updates (UML,
> Sparc, ia64, ppc64 and ARM).

One of yours hand merged UML updates/fixes in, and another one broke it badly by introducing
sigprocmask(). Now there is a conflict between in-kernel sigprocmask() and
glibc's sigprocmask() (that UML uses to manage signal delivery to right thread).
Can we please change the name of in-kernel's sigprocmask() to avoid name clash? ;)
Jeff Dike is also seem to support idea of renaming the offending function.

Thank you.

Bye,
    Oleg
