Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbUKLA4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUKLA4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbUKLA4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:56:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:58242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbUKLAvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:51:46 -0500
Date: Thu, 11 Nov 2004 16:51:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Juerg Billeter <juerg@paldo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Don't remove /sys in initramfs
Message-Id: <20041111165132.396f5c44.akpm@osdl.org>
In-Reply-To: <1100190828.5888.0.camel@juerg-p4.bitron.ch>
References: <1100190828.5888.0.camel@juerg-p4.bitron.ch>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juerg Billeter <juerg@paldo.org> wrote:
>
> Using the "resume" kernel parameter together with an initramfs revealed
>  a bug that causes removal of the /sys directory in the initramfs' tmpfs,
>  making the system unbootable.
> 
>  The source of the problem is that the try_name() function removes
>  the /sys directory unconditionally, instead of removing it only when it
>  has been created by try_name().
> 
>  The attached patch only removes /sys if it has been created before.

The patch looks sane.  Your email client replaced tabs with spaces.  I
fixed that up.  In future, please send the patch to yourself first, check
that it still applies, then send it on, thanks.
