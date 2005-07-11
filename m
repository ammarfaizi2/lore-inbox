Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVGKE65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVGKE65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 00:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVGKE65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 00:58:57 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50857
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262232AbVGKE65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 00:58:57 -0400
Date: Sun, 10 Jul 2005 21:58:47 -0700 (PDT)
Message-Id: <20050710.215847.41634202.davem@davemloft.net>
To: nish.aravamudan@gmail.com
Cc: jgarzik@pobox.com, olh@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much,
 for no good reason.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <29495f1d050710211862c4e543@mail.gmail.com>
References: <20050710.144910.15269860.davem@davemloft.net>
	<42D1A039.9090807@pobox.com>
	<29495f1d050710211862c4e543@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nish Aravamudan <nish.aravamudan@gmail.com>
Date: Sun, 10 Jul 2005 21:18:15 -0700

> A quick question here regarding the possibility of one logical change
> for all of drivers/. Does that hold true for *any* logical change?
> 
> Intuitively, I would say no. My biggest concern with that is there are
> many Maintainers listed for particular SCSI drivers, e.g., as well as
> one for the SCSI subsystem. If those individual driver maintainers'
> files are being modified, should they be CC'ed, or is the big patch
> just sent to the SCSI maintainer (in this example)? I just want to
> make sure the correct patch-chain is respected.

Please just use common sense.  It depends upon how intrusive the
change is.  In most cases, the driver author's have to learn to
"let go" and let these general cleanups happen.  The onus is on
them to follow upstream when the submit new changes of their own.

Some examples:

1) Deleting superfluous header file.

   Just do a clean sweep.

2) Adding a new argument to an existing interface.

   Just do a clean sweep.

3) Transitioning drivers over to a new exception handling mechanism.

   Probably want to do submit a patch for driver at a time.  You
   should be doing more a few of these driver conversions at a time
   anyways, so no risk of patch bombing.

4) Straight forward transformations, for example hiding data
   structure member access behind a function or macro.

   Just do a clean sweep in large chunks.

Again, use common sense.  If you're just crossing your "T"'s and
dotting your "i"'s, don't spam everyone with a thousand patches
for such a cleanup.

