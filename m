Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUAPNPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUAPNPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:15:11 -0500
Received: from camus.xss.co.at ([194.152.162.19]:50437 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S265442AbUAPNPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:15:01 -0500
Message-ID: <4007E3C1.1020100@xss.co.at>
Date: Fri, 16 Jan 2004 14:14:41 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, andrew@walrond.org,
       luming.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: ACPI: problem on ASUS PR-DLS533
References: <3ACA40606221794F80A5670F0AF15F8401720CA8@PDSMSX403.ccr.corp.intel.com>	<200401151814.35064.andrew@walrond.org>	<Pine.LNX.4.58L.0401160826090.28357@logos.cnet> <20040116122550.23331cf5.skraw@ithnet.com>
In-Reply-To: <20040116122550.23331cf5.skraw@ithnet.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Stephan von Krawczynski wrote:
> On Fri, 16 Jan 2004 08:30:13 -0200 (BRST)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>
>>>I don't know if Stephan filed the report as you requested, but I have tried
>>>to independantly confirm this regression on a TR-DLSR server I have here,
>>>but unfortunately neither 2.4.23 or 2.4.24 will boot from the Mylex 170
>>>Raid card(DAC960) with ACPI enabled, so I never get to lspci :(
>>>
>>>I could perhaps capture the boot messages over serial port, if that would
>>>be helpful?
>>
>>Yes, please, with and without ACPI. (I suppose disabling ACPI fixes the
>>problem?)
>>
>>Stephan: There is nothing from 2.4.23 to .24 which could cause such
>>breakage. It probably didnt work with 2.4.23 also?
>
>
> Hello,
>
> I am sorry for the long delay, I ran completely out of time unfortunately.
> In short:
> You are right, there is no regression between .23 and .24, shoot me.
> Anyway I know there was a former kernel that worked with ACPI on this board.
> I wanted to return the info which one though, but don't have it yet.
> Anyway as soon as I find some spare time I will go hunting...
>
For the system I noticed the ACPI problems (Asus PR-DLS533),
the regression occured after 2.4.21

With pristine 2.4.21 the system could boot with ACPI enabled,
but with the new ACPI patches introduced with the 2.4.21-ac
series (and integrated in the 2.4.x series later on) it did not.

Does your board have several PCI busses (lspci -v) ?
It seems the problem is with the BIOS not correctly initializing
and/or reporting some ACPI data structures, so the Linux ACPI code
does not find (and therefore initialize) some devices on higher PCI
bus numbers.

It looks like it's Asus who should fix their BIOS.

Does anyone know how the other OS(tm) does handle
ACPI PCI bus initialisation on these boards? Do
they have some workaround for such broken BIOS?
(I have never tried the other OS(tm) on this board)

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAB+O/xJmyeGcXPhERArLfAKCgPxnCWEA2gSC4O0k9plGhNp231gCgpz1m
TVH4WHTDK2u+4HVFZA3x0m4=
=NyKq
-----END PGP SIGNATURE-----

