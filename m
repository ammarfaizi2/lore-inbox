Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTEZFS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTEZFS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:18:56 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:56400 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264266AbTEZFSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:18:49 -0400
Subject: Re: [RFC] Fix NMI watchdog documentation
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200305260236.h4Q2ala7003115@turing-police.cc.vt.edu>
References: <200305251050.h4PAoSoG028882@harpo.it.uu.se>
	 <200305260236.h4Q2ala7003115@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1053927100.1291.7.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 01:31:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-25 at 22:36, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 25 May 2003 12:50:28 +0200, mikpe@csd.uu.se said:
> 
> > The blacklist rule is a catch-all since we don't have detailed DMI
> > data on all Inspiron/Latitude models, and at the time, _all_ of them
> > were broken. Looking through my records, Inspiron 8000 and 8100, and
> > Latitude C600, C610, C640, C800, and C810 are known to be broken. Note
> > that this includes at least one P4-based machine (C640), so it's not
> > restricted to "old" mobile P3s.
> 
> OK, I put together a kernel that had the Latitude blacklist commented out,
> and it comes up with:
> 
> No local APIC present or hardware disabled
> Initializing CPU#0
> 
> So add the Latitude C840 to the "known b0rken" list.

Ditto the Inspiron 8500 - no apic at all (which is different from
known-broken, since nothing bad happened.)  

For cleanliness sake it would be nice to have specific model info in the
blacklist ("your hardware doesn't have a frobber" is nicer than "the
frobber on your hardware causes your pets to catch fire"), but since the
hardware doesn't exist anyway the end result is the same. (And the code
is a lot more readable.)

Perhaps just a comment above those entries:
/* Latitude C840 and Inspiron 8500 have no APIC support in hardware */

Eventually it might even turn into a proper whitelist/blacklist
collection.

-- 
Disconnect <lkml@sigkill.net>

