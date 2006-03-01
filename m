Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWCAUxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWCAUxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWCAUxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:53:25 -0500
Received: from mx03.kontent.de ([81.88.34.122]:8147 "EHLO MX03.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751197AbWCAUxZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:53:25 -0500
From: Oliver Neukum <oliver@neukum.org>
To: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: MAX_USBFS_BUFFER_SIZE
Date: Wed, 1 Mar 2006 21:53:20 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200603012116.25869.rene@exactcode.de>
In-Reply-To: <200603012116.25869.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603012153.20723.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. März 2006 21:16 schrieb René Rebe:
> Hi,
> 
> I wonder if:
> 
> drivers/usb/core/devio.c:86
> #define MAX_USBFS_BUFFER_SIZE   16384
> 
> is some random, or outdated limit or if there really is some code path that could
> not handle bigger URBs.

We are nice to the VM. 16384 is optimistic anyway. You cannot expect
to repeatedly and reliably allocate larger buffers.

	Regards
		Oliver
