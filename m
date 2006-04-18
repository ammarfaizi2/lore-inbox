Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWDRFRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWDRFRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 01:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWDRFRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 01:17:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39875 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932224AbWDRFRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 01:17:37 -0400
Date: Mon, 17 Apr 2006 22:13:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: <dustin@sensoria.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net driver: Add support for SMSC LAN911x line of
 ethernet chips
Message-Id: <20060417221345.29f16809.akpm@osdl.org>
In-Reply-To: <021e01c66285$ca8b0a40$0a67020a@dustinlaptop>
References: <021e01c66285$ca8b0a40$0a67020a@dustinlaptop>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dustin McIntire" <dustin@sensoria.com> wrote:
>
> This patch adds support for the SMSC LAN911x line of Ethernet chips.  These
>  Ethernet controllers are a completely new register set from the old 91c9x
>  and 91c911x parts.  This driver has been tested using a PXA255 host
>  processor, but has not been tested under other architectures.  The driver
>  was written in a hopefully generic enough way to extend support beyond just
>  the ARM.  I'm hoping for comments regarding its suitability for inclusion
>  into the kernel tree.

The patch was badly wordwrapped.  Please fix and resend.

I'd suggest that you enable it on all architectures, not just CONFIG_ARM. 
Tht way we'll at least get compile coverage.

Coding style problems:

- The code uses four-spaces where it should be using hard tabs.  Linux
  style is to always use hard tabs.

- The code does this:

	if(
	while(

  Linux style is

	if (
	while (

- Try to keep everything inside the 80th column.  (This is especially
  useful when sending wordwrapped patches ;))
