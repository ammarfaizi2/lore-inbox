Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTEVATI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTEVATI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:19:08 -0400
Received: from mail.casabyte.com ([209.63.254.226]:25102 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262378AbTEVATG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:19:06 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <viro@parcelfarce.linux.theplanet.co.uk>
Cc: <root@chaos.analogic.com>, "Helge Hafting" <helgehaf@aitel.hist.no>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: recursive spinlocks. Shoot.
Date: Wed, 21 May 2003 17:32:00 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGAEIFCMAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030522001358.GB14406@parcelfarce.linux.theplanet.co.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yep, I kind of figured that was going to happen... (doh! 8-)

(I was groping for the example without my references at hand.  My bad for
crediting someone with willingness to reason when I know they deliberately
do not want to get the point...  My apologies to the rest of the list
here... 8-)

Did my error in routine selection render you so fixated on counting coup
that you TOTALLY missed the point about aggregation of operations?

I bet it did...

/sigh

-----Original Message-----
From: viro@www.linux.org.uk [mailto:viro@www.linux.org.uk]On Behalf Of
viro@parcelfarce.linux.theplanet.co.uk
Sent: Wednesday, May 21, 2003 5:14 PM
To: Robert White
Cc: root@chaos.analogic.com; Helge Hafting; Linux kernel
Subject: Re: recursive spinlocks. Shoot.


On Wed, May 21, 2003 at 02:56:12PM -0700, Robert White wrote:
> Lets say I have a file system with a perfectly implemented unlink and a
> perfectly implemented rename.  Both of these routines need to exist
exactly
> as they are.  Both of these routines need to lock the vfs dentry subsystem
> (look it up.)

_Do_ look it up.  Neither ->unlink() nor ->rename() need to do anything with
any sort of dentry locking or modifications.

Illustrates the point rather nicely, doesn't it?  What was that about
taking locks out of laziness and ignorance, again?  2%?  You really
like to feel yourself a member of select group...

Unfortunately, that group is nowhere near that select - look up the
Sturgeon's Law somewhere.  90% of anything and all such...

