Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUBYQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUBYQp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:45:58 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:42976 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261401AbUBYQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:45:57 -0500
Date: Wed, 25 Feb 2004 16:44:46 +0000
From: Dave Jones <davej@redhat.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci rmmod fun
Message-ID: <20040225164446.GA9346@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org
References: <20040225005241.GB11203@redhat.com> <20040225193343.47b7572f.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225193343.47b7572f.vsu@altlinux.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 07:33:43PM +0300, Sergey Vlasov wrote:
 > On Wed, 25 Feb 2004 00:52:41 +0000 Dave Jones wrote:
 > 
 > > (00:52:08:root@mindphaser:davej)# lsmod | grep floppy
 > > (00:52:39:root@mindphaser:davej)# modprobe usb-uhci
 > > (00:52:48:root@mindphaser:davej)# lsmod | grep floppy
 > > (00:53:02:root@mindphaser:davej)# rmmod uhci_hcd
 > > (00:53:11:root@mindphaser:davej)# lsmod | grep floppy
 > > floppy                 58260  0
 > > (00:53:13:root@mindphaser:davej)#
 > > 
 > > Unloading the usb controller loads the floppy controller!?
 > 
 > This thing seems to be triggered by updfstab (/etc/hotplug/usb.agent
 > tries to run it during the remove handling).

Bill Nottingham pointed out to me that on rmmod hotplug rescans
all removable media, which seems a bit wacky, but that does
seem to be the case.

		Dave

