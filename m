Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbUJ0Pqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbUJ0Pqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUJ0Pmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:42:54 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:33959 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S262494AbUJ0Pkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:40:36 -0400
Date: Wed, 27 Oct 2004 17:39:50 +0200 (CEST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-2go.math.uni-giessen.de
To: Andreas Klein <Andreas.C.Klein@physik.uni-wuerzburg.de>
Cc: Andi Kleen <ak@muc.de>, Andrew Walrond <andrew@walrond.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: solution Re: lost memory on a 4GB amd64
In-Reply-To: <Pine.LNX.4.58.0410271704050.3903@pluto.physik.uni-wuerzburg.de>
Message-Id: <Pine.LNX.4.58.0410271718050.10573@fb07-2go.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409241315.42740.andrew@walrond.org> <Pine.LNX.4.58.0410221053390.17491@fb07-2go.math.uni-giessen.de>
 <200410221026.22531.andrew@walrond.org> <20041022182446.GA77384@muc.de>
 <Pine.LNX.4.58.0410231220400.17491@fb07-2go.math.uni-giessen.de>
 <20041023164902.GB52982@muc.de> <Pine.LNX.4.58.0410241133400.17491@fb07-2go.math.uni-giessen.de>
 <Pine.LNX.4.58.0410271704050.3903@pluto.physik.uni-wuerzburg.de>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Andreas Klein (AK) wrote:

AK> Hello,
AK> 
AK> the problem has been verified by Tyan. It is definately a hardware issue.
AK> The Tyan and AMD engineers are developing a solution (BIOS) for the 
AK> problem.
AK> They will fix the problem for the S2885, as weel as for the S2875 boards.

Are you sure this is the same problem, that I have? You discovered
Problems with memtest86:

> Memtest sees 0-2GB mem usable and 4-6GB unusable (complains 
> about each memory address).

I didn't:

> memtest86 is happy with the memory.

The next difference: 
You have the S2885 (thunder K8W) and S2875S (tiger K8W single processor) 
boards and I have a S2875 (tiger K8W double processor)


I summarize (again) my problems:

Independantly of the memory settings in the BIOS:
 - non-SMP Kernel is stable
 - memtest86 does not report any errors

If the memory (4GB) is set up in one block (0-4GB) in the BIOS, then
 - SMP Kernel is stable 

If the memory (4GB) is set up in two blocks (eg. 0-3GB, 4-5GB) in the
BIOS, then
 - SMP Kernel is stable _if_and_only_if_ NUMA is _disabled_.


BTW.: I won't be able to flash a new BIOS to our machine, since it is in 
production use and runs _rock_stable_ with _full_memory_ after we
_disabled_ NUMA support in the kernel. (see the two small programs posted 
by me and by Andi Kleen)

What I COULD do is running some tests if needed. (e.g. to check if the 
Board/BIOS is lying about its capabilities)


        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
