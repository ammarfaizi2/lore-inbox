Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270162AbVBESB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270162AbVBESB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbVBESB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:01:28 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:7946 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S270136AbVBESBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:01:14 -0500
Message-ID: <420509D1.2080401@tuxrocks.com>
Date: Sat, 05 Feb 2005 11:00:49 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [patch] Make User Mode Linux compile in 2.6.11-rc3
References: <200502051051.46242.rob@landley.net>
In-Reply-To: <200502051051.46242.rob@landley.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rob Landley wrote:
| As of yesterday afternoon, the UML build still breaks in
sys_call_table.c,
| here's the patch I submitted earlier (which got me past the break when I
| tried it).  Last week, this produced what seemed like a working UML.
|
| Now there's a second break in mm/memory.c: the move to four level page
| tables conflicts with a stub in our headers.  Not quite sure how to
fix that.
| Jeff?
|
| (Yeah, I know Andrew's tree works.  But wouldn't it be nice if the
kernel.org
| tree to worked too, before 2.6.11 release.)

This patch for sys_call_table.c was merged into the main tree in this
changeset:
http://linux.bkbits.net:8080/linux-2.5/cset@1.2080?nav=index.html|ChangeSet@-2d

The patch fixes both the sys_call_table and the pud_alloc breakage, and
as of 2.6.11-rc3-bk2, the main tree compiles again for UML.

Andrew's tree, however, (at least 2.6.11-rc3-mm1) requires the patch I
sent out yesterday in the message titled "Fix compilation of UML after
the stack-randomization patches."

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCBQlRaI0dwg4A47wRAjJ8AJ9CKD/aXaz1TS9QfOO11vcsv+57BACg1CdJ
GR0ukCKAabFtJs5rVsPItGg=
=h/on
-----END PGP SIGNATURE-----
