Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbTAZBDz>; Sat, 25 Jan 2003 20:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266527AbTAZBDs>; Sat, 25 Jan 2003 20:03:48 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:53888 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266535AbTAZBCg>;
	Sat, 25 Jan 2003 20:02:36 -0500
Date: Sat, 25 Jan 2003 20:15:31 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, "Ruslan U. Zakirov" <cubic@wildrose.miee.ru>
Subject: [PATCH] trivial fix to card.c from Ruslan Zakirov (6/6)
Message-ID: <20030125201531.GA12861@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	"Ruslan U. Zakirov" <cubic@wildrose.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

removes the duplicate __pnp_remove_device.

--- drivers/pnp/card.c~ 2003-01-15 13:52:08.000000000 +0300
+++ drivers/pnp/card.c  2003-01-15 13:52:16.000000000 +0300
@@ -144,7 +144,6 @@
        list_for_each_safe(pos,temp,&card->devices){
                struct pnp_dev *dev = card_to_pnp_dev(pos);
                pnpc_remove_device(dev);
-               __pnp_remove_device(dev);
        }
 }
