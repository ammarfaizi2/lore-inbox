Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968029AbWLGDg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968029AbWLGDg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 22:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968053AbWLGDg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 22:36:27 -0500
Received: from ozlabs.org ([203.10.76.45]:46590 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968029AbWLGDg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 22:36:26 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, fastboot@lists.osdl.org
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] free initrds boot option 
In-reply-to: <4577624A.6010008@zytor.com> 
References: <4410.1165450723@neuling.org> <20061206163021.f434f09b.akpm@osdl.org> <4577624A.6010008@zytor.com>
Comments: In-reply-to "H. Peter Anvin" <hpa@zytor.com>
   message dated "Wed, 06 Dec 2006 16:37:30 -0800."
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 21.4.1
Date: Thu, 07 Dec 2006 14:36:18 +1100
Message-ID: <13639.1165462578@neuling.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would have to agree with this; it also seems a bit odd to me to have
> this at all (kexec provides a new kernel image, surely it also
> provides a new initrd image???)

The first boot will need to hold a copy of the in memory fs for the
second boot.  This image can be large (much larger than the kernel),
hence we can save time when the memory loader is slow.  Also, it reduces
the memory footprint while extracting the first boot since you don't
need another copy of the fs.

New patch on it's way.  

Mikey
