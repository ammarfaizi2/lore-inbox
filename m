Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933568AbWLCNwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933568AbWLCNwm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759684AbWLCNwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:52:42 -0500
Received: from mx3.mail.ru ([194.67.23.149]:14670 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1759681AbWLCNwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:52:41 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sun, 3 Dec 2006 16:52:36 +0300
User-Agent: KMail/1.9.5
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200612031526.00861.arvidjaar@mail.ru> <20061203131124.GG4773@ucw.cz>
In-Reply-To: <20061203131124.GG4773@ucw.cz>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612031652.38155.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 03 December 2006 16:11, Pavel Machek wrote:
> Hi!
>
> > I started to notice it some time ago; I can't say exactly if this was not
> > present in earlier versions because recently I switched from STR (which
> > gave me no end of troubles) to STD. So I may have not seen it before.
> >
> > Suspend to disk while on battery. Plug in AC, resume. ACPI continues to
> > show AC adapter as not present:
> >
> > {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
> > state:                   off-line
> >
> > replugging AC correctly changes state to on-line.
>
> try echo platform > /sys/power/disk.

Nope.

{pts/0}% pmsuspend disk
... after resume
{pts/0}% cat /sys/power/disk
platform
{pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
state:                   off-line
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFctamR6LMutpd94wRAqnCAJwKi4wXUj2FRkD2tyq+c0gqAghnrgCgyKYZ
lep/19gowY3OTGIkpzcasfU=
=4Cgb
-----END PGP SIGNATURE-----
