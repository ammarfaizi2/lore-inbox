Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVEZPyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVEZPyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 11:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVEZPyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 11:54:20 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:52098 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261579AbVEZPxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 11:53:48 -0400
Date: Thu, 26 May 2005 17:53:44 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Domen Puncer <domen@coderock.org>, Rene Herman <rene.herman@keyaccess.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050526155344.GB3694@ucw.cz>
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org> <20050526122315.GA3880@nd47.coderock.org> <20050526154509.GB9443@animx.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20050526154509.GB9443@animx.eu.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 26, 2005 at 11:45:09AM -0400, Wakko Warner wrote:
> Domen Puncer wrote:
> > Still true for 2.6.12-rc5. Should probably be fixed before final.
> 
> I also have a problem with 2.6.12-rcX and ps/2 keyboard.  I would say it's
> the same key we're talking about.  It does not work at the console nor in X
> (showkey at the console does not see it).  It works with a USB keyboard.  My
> "compose" is mapped to the menu key beside the right windows key.
> 
> I do wish they'd fix it, because I use this key (kinda like another ALT key)
> more than my compose key (again, the menu key, not the right win logo key)
 
This patch should fix it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=atkbd-fix-scroll

ChangeSet@1.2229.1.9, 2005-04-04 15:37:45+02:00, vojtech@suse.cz
  input: Fix fast scrolling scancodes in atkbd.c
    
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 atkbd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2005-05-03 15:23:34 +02:00
+++ b/drivers/input/keyboard/atkbd.c	2005-05-03 15:23:34 +02:00
@@ -171,9 +171,9 @@
 	unsigned char set2;
 } atkbd_scroll_keys[] = {
 	{ ATKBD_SCR_1,     0xc5 },
-	{ ATKBD_SCR_2,     0xa9 },
-	{ ATKBD_SCR_4,     0xb6 },
-	{ ATKBD_SCR_8,     0xa7 },
+	{ ATKBD_SCR_2,     0x9d },
+	{ ATKBD_SCR_4,     0xa4 },
+	{ ATKBD_SCR_8,     0x9b },
 	{ ATKBD_SCR_CLICK, 0xe0 },
 	{ ATKBD_SCR_LEFT,  0xcb },
 	{ ATKBD_SCR_RIGHT, 0xd2 },

--gBBFr7Ir9EOA20Yy--
