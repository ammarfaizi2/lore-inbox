Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWGNCQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWGNCQL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWGNCQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:16:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161167AbWGNCQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:16:10 -0400
Date: Thu, 13 Jul 2006 19:15:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Aleksey Gorelov <dared1st@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] Properly unregister reboot notifier in case of failure
 in ehci hcd
Message-Id: <20060713191559.53ba7726.akpm@osdl.org>
In-Reply-To: <20060712063841.18958.qmail@web81202.mail.mud.yahoo.com>
References: <20060712063841.18958.qmail@web81202.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 23:38:41 -0700 (PDT)
Aleksey Gorelov <dared1st@yahoo.com> wrote:

>   If some problem occurs during ehci startup, for instance, request_irq fails, echi hcd driver
> tries it best to cleanup, but fails to unregister reboot notifier, which in turn leads to crash on
> reboot/poweroff. Below is the patch against current git to fix this.
>   I did not check if the same problem existed for uhci/ohci host drivers.

This patch causes hangs at reboot/shutdown/suspend time.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/dsc03597.jpg
