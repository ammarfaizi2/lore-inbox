Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUC1Xlb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 18:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbUC1Xlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 18:41:31 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:20916 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S262488AbUC1Xl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 18:41:29 -0500
Subject: Re: [Swsusp-devel] [PATCH 2.6]: suspend to disk only available if
	non-modular IDE
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
In-Reply-To: <200403282136.55435.arekm@pld-linux.org>
References: <200403282136.55435.arekm@pld-linux.org>
Content-Type: text/plain
Message-Id: <1080517040.2223.3.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Mon, 29 Mar 2004 11:37:20 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to 2.4 and 2.6.

Thanks and regards,

Nigel

On Mon, 2004-03-29 at 07:36, Arkadiusz Miskiewicz wrote:
> Hi,
> 
> resume from disk doesn't work when using modular IDE so this patch disables
> this in config:
> 
> --- kernel/power/Kconfig~       2004-03-28 21:32:03.198944320 +0200
> +++ kernel/power/Kconfig        2004-03-28 21:32:25.988479784 +0200
> @@ -44,7 +44,7 @@
> 
>  config PM_DISK
>         bool "Suspend-to-Disk Support"
> -       depends on PM && SWAP
> +       depends on PM && SWAP && IDE=y && BLK_DEV_IDEDISK=y
>         ---help---
>           Suspend-to-disk is a power management state in which the contents
>           of memory are stored on disk and the entire system is shut down or
> 
> Info here:
> http://groups.google.com/groups?selm=1BdIH-5WB-17%40gated-at.bofh.it&oe=UTF-8&output=gplain
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

