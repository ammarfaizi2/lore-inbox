Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUAOUzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUAOUx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:53:57 -0500
Received: from schrell.de ([217.160.107.182]:15232 "HELO schrell.de")
	by vger.kernel.org with SMTP id S261595AbUAOUv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:51:27 -0500
Message-ID: <3450.80.146.4.230.1074199906.squirrel@www.schrell.de>
In-Reply-To: <20040115083050.333bb13d.rddunlap@osdl.org>
References: <20040113215355.GA3882@piper.madduck.net><20040115102231.37a84ed0.rusty@rustcorp.com.au><20040115080815.GA2806@piper.madduck.net>
    <20040115083050.333bb13d.rddunlap@osdl.org>
Date: Thu, 15 Jan 2004 21:51:46 +0100 (CET)
Subject: Re: modprobe failed: digest_null
From: "Andreas Schrell" <as@schrell.de>
To: "lkml" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am quite sure this message comes from freeswan 2.04.

programs/pluto/kernel_netlink.c:        { SADB_X_AALG_NULL, "digest_null" },

Think it could be fixed by replacing digest_null with crypto_null (or modprobing
crypto_null manually before starting freeswan) but then the next problem with

kernel: request_module: failed /sbin/modprobe -- ripemd160. error = 256

from same freeswan source file...

Andreas

PS: sorry, Randy for dublette...

> On Thu, 15 Jan 2004 09:08:15 +0100 martin f krafft <madduck@madduck.net> wrote:
>
> | also sprach Rusty Russell <rusty@rustcorp.com.au> [2004.01.15.0022 +0100]:
> | > Upgrade module-init-tools to 0.9.14 or one of the 3.0 -pres.
> |
> | diamond:~# modprobe -V
> | module-init-tools version 3.0-pre5
>
> Yes, and I'm using 0.9.14 and seeing similar messages.
>
> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

