Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWAWGAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWAWGAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 01:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWAWGAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 01:00:33 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:16763 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964823AbWAWGAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 01:00:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: [PATCH] INPUT: add MODALIAS to the event environment
Date: Mon, 23 Jan 2006 01:00:28 -0500
User-Agent: KMail/1.9.1
Cc: Kay Sievers <kay.sievers@suse.de>, Greg K-H <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <11371818082670@kroah.com> <20060114110401.GA11237@vrfy.org> <43C8F962.9030409@ums.usu.ru>
In-Reply-To: <43C8F962.9030409@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230100.29818.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 08:15, Alexander E. Patrakov wrote:
> NAME="GenPS/2 Genius <NULL>"

                        ^^^^^ This is bad. It should say "GenPS/2
Genius Mouse". Please try the patch below. Thanks!

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/psmouse-base.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -403,6 +403,7 @@ static int genius_detect(struct psmouse 
 		set_bit(REL_WHEEL, psmouse->dev->relbit);
 
 		psmouse->vendor = "Genius";
+		psmouse->name = "Mouse";
 		psmouse->pktsize = 4;
 	}
 
