Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSKUFD5>; Thu, 21 Nov 2002 00:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbSKUFD5>; Thu, 21 Nov 2002 00:03:57 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36614
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263039AbSKUFDz>; Thu, 21 Nov 2002 00:03:55 -0500
Date: Wed, 20 Nov 2002 21:10:41 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: TAINTED (Re: spinlocks, the GPL, and binary-only modules)
In-Reply-To: <Pine.LNX.4.44L.0211210024070.4103-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.10.10211202039180.3892-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings LKML,

There is an interesting paradox to now consider.

Now the folks who invisioned the process to "taint" a kernel have by
default given the rule of exemption to the use of binary only.  The very
process used to detect and determine "taint", has itself approved the use
of binary only!  If this was not the case, then the detection process
would have rejected the loading.  Since this in not the end result, the
claim is and will be made the headers and all api's are exempt, period.

The headers and api's are required to even obtain functionality.

The test for Tainted status below:

"Module                  Size  Used by    Tainted: P"

It allows/allowed a binary module to load.


If Linux is to truly only a GPL binary module friendly environment, then
it must enforce the rules.  Therefore it must forcablely reject the
attempt to load any and all binaries which are not GPL.  Regardless if the
license is commerial yet the source code is available.

Think long and hard before this step is taken, as it will crush the
viablity of Linux in many key places today and will delay future
deployment.

This shall force all distos to change policy and prevent the loading of
anything which is not GPL and they have the source code to ship.
Additionall

To this point, the issue is closed on the binary modules.

/*
 * The following license idents are currently accepted as indicating free
 * software modules
 *
 *      "GPL"                           [GNU Public License v2 or later]
 *      "GPL and additional rights"     [GNU Public License v2 rights and more]
 *      "Dual BSD/GPL"                  [GNU Public License v2 or BSD license choice]
 *      "Dual MPL/GPL"                  [GNU Public License v2 or Mozilla license choice]
 *
 * The following other idents are available
 *
 *      "Proprietary"                   [Non free products]
 *
 * There are dual licensed components, but when running with Linux it is the
 * GPL that is relevant so this is a non issue. Similarly LGPL linked with GPL
 * is a GPL combined work.
 *
 *
 * This exists for several reasons
 * 1.   So modinfo can show license info for users wanting to vet their setup
 *      is free
 * 2.   So the community can ignore bug reports including proprietary modules
 * 3.   So vendors can do likewise based on their own policies
 */

Again, this very file ./linux/include/linux/module.h grants permission for:
    "Proprietary"                   [Non free products]

Now disbute the kernel!

Cheers,

Andre Hedrick
LAD Storage Consulting Group

PS The issue which is not closed is the legal status of what is a derived
   work and what is an original work.  This shall be settled in court when
   it is challanged.


