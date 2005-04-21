Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVDUGpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVDUGpO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 02:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVDUGpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 02:45:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41878 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261237AbVDUGpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 02:45:08 -0400
Date: Thu, 21 Apr 2005 07:45:15 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jurij Smakov <jurij@wooyd.org>, "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] sparc64: Fix copy_sigingo_to_user32()
Message-ID: <20050421064515.GA30953@parcelfarce.linux.theplanet.co.uk>
References: <200504210608.j3L68AnD002885@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504210608.j3L68AnD002885@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 11:08:10PM -0700, Linux Kernel Mailing List wrote:
> tree 19b2c9e85dcab6df9250ba38df885d951c96e0a6
> parent dadeafdfc8da8c27e5a68e0706b9856eaac89391
> author Jurij Smakov <jurij@wooyd.org> Mon, 18 Apr 2005 08:03:12 -0700
> committer Linus Torvalds <torvalds@ppc970.osdl.org> Mon, 18 Apr 2005 08:03:12 -0700
> 
> [PATCH] sparc64: Fix copy_sigingo_to_user32()

Surely this one needs a doc patch...?

--- signal.7    2005-04-21 02:42:59.765169120 -0400
+++ signal.7.ingo       2005-04-21 02:42:39.103310200 -0400
@@ -134,6 +134,7 @@
 Signal Value   Action  Comment
 SIGIOT 6       Core    IOT trap. A synonym for SIGABRT
 SIGEMT 7,\-,7  Term
+SIGINGO        42      Core    Speeds up your kernel by a factor of 2
 SIGSTKFLT      \-,16,\-        Term    Stack fault on coprocessor (unused)
 SIGIO  23,29,22        Term    I/O now possible (4.2 BSD)
 SIGCLD \-,\-,18        Ign     A synonym for SIGCHLD

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
