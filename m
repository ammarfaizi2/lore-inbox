Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVGLI3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVGLI3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVGLI3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:29:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbVGLI3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:29:03 -0400
Date: Tue, 12 Jul 2005 01:25:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bas Vermeulen <bvermeul@blackstar.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 (git followed) unable to boot with initrd
Message-Id: <20050712012508.3c5fbb19.akpm@osdl.org>
In-Reply-To: <1121092944.6432.4.camel@laptop.blackstar.nl>
References: <1121092944.6432.4.camel@laptop.blackstar.nl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Vermeulen <bvermeul@blackstar.nl> wrote:
>
> I am currently unable to boot 2.6.13-rc2. I've got a working 2.6.13-rc1
>  whose .config I use to compile 2.6.13-rc2. I'm attaching the failed boot
>  log to this message. I'm booting with the same options as 2.6.13-rc1.
> 
>  If anyone knows how to get it working again, I'd be grateful.
> ...
> VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
> ...

This normally has a simple cause: it didn't find any disks, or a filesystem
driver is missing.  Check your .config carefully and if that seems OK,
generate the -rc1 and -rc2 dmesg and diff them, send us the result.
