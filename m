Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbTCSOWh>; Wed, 19 Mar 2003 09:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbTCSOWh>; Wed, 19 Mar 2003 09:22:37 -0500
Received: from [213.171.53.133] ([213.171.53.133]:13325 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S263022AbTCSOWg>;
	Wed, 19 Mar 2003 09:22:36 -0500
Date: Wed, 19 Mar 2003 17:38:28 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <1071562118888.20030319173828@wr.miee.ru>
To: John Kim <john@larvalstage.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.65] pnp api changes to sound/isa/sb/es968.c
In-Reply-To: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com>
References: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JK> Following patch is to make ESS968 driver to work with PNP API.

JK> +               printk(KERN_ERR PFX "AUDIO the requested resources are invalid, using auto config\n");
JK> +       err = pnp_activate_dev(pdev);
JK> +       if (err < 0) {
JK> +               printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
JK> +               return err;
JK> +       }
Hello, John and other.
You've forgot to kfree(cfg) in the error path.
       Best regards, Ruslan.

