Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVCUV1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVCUV1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVCUVYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:24:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:26792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262013AbVCUVVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:21:55 -0500
Date: Mon, 21 Mar 2005 13:21:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S2R gone with 2.6.12-rc1-mm1
Message-Id: <20050321132106.3cb48d38.akpm@osdl.org>
In-Reply-To: <20050321210411.GB29072@gamma.logic.tuwien.ac.at>
References: <20050321210411.GB29072@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> Hi Andrew!
> 
> Sorry to bother you again, but I found that S2R does not work anymore
> with 2.6.12-rc1-mm1, while it works with the exact same software setup
> with 2.6.11-mm4.

Oh.  suspend-to-RAM.

Would this be an ACPI regression?

> I unload the whole usb stuff (otherwise 2.6.11-mm4 won't work) and do
> exactely the same.
> 
> The differences in the kernel config files are trivial:
> 
> new stuff I answered with yes:
> +CONFIG_ACPI_HOTKEY=y
> +CONFIG_PCMCIA_IOCTL=y
> +CONFIG_AOE_PARTITIONS=16
> 
> stuff that has automatically changed (changed Kconfig I suppose)
> -CONFIG_FW_LOADER=m
> +CONFIG_FW_LOADER=y
> 
> and some modules I compiled but not use/load.
> 
> With 2.6.12-rc1-mm1 the system starts, then nothing, black screen, no
> CapsLock light, no Sysrq, no sync hard disk led activity, just plane
> frozen.
> 
> Best wishes
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Norbert Preining <preining AT logic DOT at>                 Università di Siena
> sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> WINKLEY (n.)
> A lost object which turns up immediately you've gone and bought a
> replacement for it.
> 			--- Douglas Adams, The Meaning of Liff
