Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUARLmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 06:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbUARLmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 06:42:36 -0500
Received: from camus.xss.co.at ([194.152.162.19]:36880 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S263937AbUARLmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 06:42:33 -0500
Message-ID: <400A7119.7000803@xss.co.at>
Date: Sun, 18 Jan 2004 12:42:17 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Yu, Luming" <luming.yu@intel.com>
CC: Stephan von Krawczynski <skraw@ithnet.com>, marcelo.tosatti@cyclades.com,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: ACPI: problem on ASUS PR-DLS533
References: <3ACA40606221794F80A5670F0AF15F8401720CE9@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CE9@PDSMSX403.ccr.corp.intel.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Yu, Luming wrote:
> I missed this thread for a few days, What's the conclusion?
>
Good question! :-)

It seems clear, the problem stems from a broken BIOS which
does not correctly initialize some ACPI data structures.
It seems, the specific problem occurs on several different
motherboards, but they are all from the same vendor (ASUS).

So IMHO there are the following possibilities:

a) Find a workaround for this class of broken BIOS behaviour
   in the Linux ACPI code.
   I do not know if this is A Good Thing(tm) though (and if
   it's even possible). This should be decided by the Linux
   ACPI driver maintainers. Several bug reports are filed in
   the OSDL Bugzilla system already (for example,  see
   <http://bugme.osdl.org/show_bug.cgi?id=1662> and
   <http://bugme.osdl.org/show_bug.cgi?id=1741>)

b) Wait for the vendor to fix the problem in the BIOS.
   This requires to file a bug report with the vendor first,
   of course. For this it would be necessary to describe the
   issue in detail and make clear that it's a BIOS problem
   and not a Linux problem. And it would be necessary the
   vendor acknowledges the problem.
   Alas, in my experience chances are high that any bug report
   of this kind vanishes in the dungeons of a vendors internal
   bug report escalation strategy... (Does anyone know a direct
   technical contact at ASUS?)

c) Ignore it and disable Linux ACPI support on these motherboards


Any comments?

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFACnEPxJmyeGcXPhERAmKEAKC6ED8nghvXV4ti2DLEOOcnhKnLIACfdupb
RNztxbT71WtLMF51siS6cKk=
=BZZ6
-----END PGP SIGNATURE-----

