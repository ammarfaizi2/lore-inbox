Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWG0T5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWG0T5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWG0T5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:57:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751015AbWG0T5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:57:05 -0400
Date: Thu, 27 Jul 2006 12:56:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: andrew.j.wade@gmail.com, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-Id: <20060727125655.f5f443ea.akpm@osdl.org>
In-Reply-To: <200607281546.09592.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<200607281546.09592.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 15:46:08 -0400
Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> Hello,
> 
> Some change between -rc1-mm2 and -rc2-mm1 broke Kubuntu's udev
> (079-0ubuntu34). In particular /dev/mem went missing, and /dev/null had
> bogus permissions (crw-------). I've kludged around the problem by
> populating /lib/udev/devices from a good /dev, but I'm assuming the
> breakage was unintentional.
> 

/dev/null damage is due to a combination of vdso-hash-style-fix.patch and
doing the kernel build as root (don't do that).

I don't know what happened to /dev/mem.
