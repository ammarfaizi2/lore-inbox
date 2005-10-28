Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVJ1Kv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVJ1Kv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbVJ1Kv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:51:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965187AbVJ1Kv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:51:56 -0400
Date: Fri, 28 Oct 2005 03:51:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg K-H <greg@kroah.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, david-b@pacbell.net,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pci device wakeup flags
Message-Id: <20051028035116.112ba2ca.akpm@osdl.org>
In-Reply-To: <11304810223093@kroah.com>
References: <11304810221338@kroah.com>
	<11304810223093@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
>  [PATCH] pci device wakeup flags
> 
>  This patch teaches "pci_dev" about the new driver model wakeup support:
> 
>   - It marks devices as supporting wakeup when "can issue PME#" is
>     listed in its PCI PM capability.
> 
>   - pci_enable_wake() refuses to enable wake if that's been disabled
>     (e.g. through sysfs).
> 
>  NOTE that a recent patch changed PCI probing, and this reverts part
>  of that change ... so that driver model initialization is again done
>  before the PCI setup.
> 
>  (One issue is that the driver model "init + add == register" pattern isn't
>  being used inside PCI ...  and that probe change worsened the problem by
>  making "add" do some "init" too.  Maybe PCI should match the driver model
>  more closely, and just grow a new "pci_dev_init" function.)

This is the patch which I've been religiously dropping from -mm because it
kills my Mac G5.  What are we doing merging this?

