Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292079AbSBTR2O>; Wed, 20 Feb 2002 12:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292083AbSBTR2F>; Wed, 20 Feb 2002 12:28:05 -0500
Received: from air-2.osdl.org ([65.201.151.6]:56074 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292079AbSBTR1y>;
	Wed, 20 Feb 2002 12:27:54 -0500
Date: Wed, 20 Feb 2002 09:22:25 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Thomas Hood <jdthood@mail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4 PNPBIOS fault
In-Reply-To: <1014169905.4978.18.camel@thanatos>
Message-ID: <Pine.LNX.4.33L2.0202200906431.3312-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 2002, Thomas Hood wrote:

| On Tue, 2002-02-19 at 18:05, Randy.Dunlap wrote:
| > Linux 2.5.4 with CONFIG_PNPBIOS=y and "pnpbios=off" oopses
| > in ahc_linux_isr() (or near there, according to the
| > System.map file).
|
| Well, that tells us a lot, because with "pnpbios=off"
| the init routine returns immediately without calling
| the BIOS.  It would appear that this isn't a PnP BIOS
| coding bug, but something subtle.

I didn't suggest that this was a PnP BIOS coding bug, but
a bug in the _called_ PnP BIOS (i.e., maybe it needs
to be blacklisted / "pnp_bios_is_utter_crap = 1" from
DMI tables).

I agree that this particluar SCSI driver has some
problems, but they didn't show up in the bug report that I
posted.  However, this was in the bug report:

| PnPBIOS: Found PnP BIOS installation structure at 0xc00f6010.
| PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb4a6, dseg 0x400.
| Unable to handle kernel paging request at virtual address 0000de3a
|  printing eip:
|  00004298

Does that dseg value of 0x400 and eip value of 0x4298 give us
any clues/hints?


More info:

Booting with "pnpbios=no-res" or with "pnpbios=no-curr"
causes the same system hang (Oops) as in the original
email report.  [Note *differences* in "no-res" and "no-curr"
vs. "nores" and "nocurr".  Reading the source helps.  :]

-- 
~Randy

