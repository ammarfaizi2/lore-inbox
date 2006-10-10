Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWJJRRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWJJRRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWJJRRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:17:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:40587 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964881AbWJJRR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:17:28 -0400
Date: Tue, 10 Oct 2006 10:15:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, roberto.castagnola@gmail.com,
       Daniel Drake <dsd@gentoo.org>, Dmitry Torokhov <dtor@mail.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/19] Input: logips2pp - fix button mapping for MX300
Message-ID: <20061010171556.GT6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="input-logips2pp-fix-button-mapping-for-mx300.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Roberto Castagnola <roberto.castagnola@gmail.com>

MX300 does not have an EXTRA_BTN - it is a simple wheel mouse with
an additional task-switcher button, which is reported as side button
(and not task button).

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/input/mouse/logips2pp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.17.13.orig/drivers/input/mouse/logips2pp.c
+++ linux-2.6.17.13/drivers/input/mouse/logips2pp.c
@@ -238,8 +238,7 @@ static struct ps2pp_info *get_model_info
 		{ 100,	PS2PP_KIND_MX,					/* MX510 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
-		{ 111,  PS2PP_KIND_MX,					/* MX300 */
-				PS2PP_WHEEL | PS2PP_EXTRA_BTN | PS2PP_TASK_BTN },
+		{ 111,  PS2PP_KIND_MX,	PS2PP_WHEEL | PS2PP_SIDE_BTN },	/* MX300 reports task button as side */
 		{ 112,	PS2PP_KIND_MX,					/* MX500 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },

--
