Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbTCLVg3>; Wed, 12 Mar 2003 16:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbTCLVg2>; Wed, 12 Mar 2003 16:36:28 -0500
Received: from [213.171.53.133] ([213.171.53.133]:44294 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S262065AbTCLVfd>;
	Wed, 12 Mar 2003 16:35:33 -0500
Date: Thu, 13 Mar 2003 00:46:03 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: ambx1@neo.rr.com
cc: linux-kernel@vger.kernel.org
Subject: Comments on latest PNP changes.
Message-ID: <Pine.BSF.4.05.10303130031450.82559-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Adam and other.
2.5.64-bk6
1) Mem leak in your rewrite of als100
+       err = pnp_activate_dev(pdev);
+       if (err < 0) {
+               printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
+               return err;
+       }
Here you've forgot add "kfree(cfg);"
2) And here
+MODULE_DEVICE_TABLE(pnp_card, snd_als100_pnpids);
type must of entries must end with "device_id", but you've changed type
from "pnp_card_device_id" to "pnp_card_id". This changes broke
compilation.
3) When I need to activate(dev)?
	Thanks, Ruslan.

