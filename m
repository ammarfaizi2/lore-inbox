Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUBYQf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUBYQeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:34:09 -0500
Received: from main.gmane.org ([80.91.224.249]:50397 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261424AbUBYQdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:33:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: usb-uhci rmmod fun
Date: Wed, 25 Feb 2004 19:33:43 +0300
Message-ID: <20040225193343.47b7572f.vsu@altlinux.ru>
References: <20040225005241.GB11203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mivlgu.ru
X-Newsreader: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004 00:52:41 +0000 Dave Jones wrote:

> (00:52:08:root@mindphaser:davej)# lsmod | grep floppy
> (00:52:39:root@mindphaser:davej)# modprobe usb-uhci
> (00:52:48:root@mindphaser:davej)# lsmod | grep floppy
> (00:53:02:root@mindphaser:davej)# rmmod uhci_hcd
> (00:53:11:root@mindphaser:davej)# lsmod | grep floppy
> floppy                 58260  0
> (00:53:13:root@mindphaser:davej)#
> 
> Unloading the usb controller loads the floppy controller!?

This thing seems to be triggered by updfstab (/etc/hotplug/usb.agent
tries to run it during the remove handling).

