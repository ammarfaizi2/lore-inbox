Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754278AbWLCQBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbWLCQBA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbWLCQBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:01:00 -0500
Received: from mx5.mail.ru ([194.67.23.25]:29765 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id S1753513AbWLCQA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:00:59 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sun, 3 Dec 2006 19:00:54 +0300
User-Agent: KMail/1.9.5
Cc: Pavel Machek <pavel@suse.cz>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200612031526.00861.arvidjaar@mail.ru> <200612031652.38155.arvidjaar@mail.ru> <4572E0BC.1060203@linux.intel.com>
In-Reply-To: <4572E0BC.1060203@linux.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612031900.55741.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 03 December 2006 17:35, Alexey Starikovskiy wrote:
> Andrey Borzenkov wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Sunday 03 December 2006 16:11, Pavel Machek wrote:
> >> Hi!
> >>
> >>> I started to notice it some time ago; I can't say exactly if this was
> >>> not present in earlier versions because recently I switched from STR
> >>> (which gave me no end of troubles) to STD. So I may have not seen it
> >>> before.
> >>>
> >>> Suspend to disk while on battery. Plug in AC, resume. ACPI continues to
> >>> show AC adapter as not present:
> >>>
> >>> {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
> >>> state:                   off-line
> >>>
> >>> replugging AC correctly changes state to on-line.
> >>
> >> try echo platform > /sys/power/disk.
> >
> > Nope.
> >
> > {pts/0}% pmsuspend disk
> > ... after resume
> > {pts/0}% cat /sys/power/disk
> > platform
> > {pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
> > state:                   off-line
>
> please look if patches in 7122 work  for you.

No. I applied patches from comments 38 and 52 (modified, it did not apply 
cleanly to 2.6.19). As far as I understood, those two were final.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcvS3R6LMutpd94wRAp9oAKCM7+6G4SsgFEGLgkW1jxM3VMQHqQCdFSDQ
14w+QsgDtxWusmfdzCMOdqo=
=QDyt
-----END PGP SIGNATURE-----
