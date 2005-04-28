Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVD1Wtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVD1Wtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVD1Wtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:49:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:34257 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262320AbVD1Wtn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:49:43 -0400
Subject: Re: very strange issue with sata,<4G Ram, and ext3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rick Warner <rick@microway.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200504281216.08026.rick@microway.com>
References: <200504281216.08026.rick@microway.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114728503.24687.248.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 23:48:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-04-28 at 17:16, Rick Warner wrote:
>  On these systems, we are getting ext2 errors from the initrd during the 
> untarring.  Soon after, we start getting seg faults on random things (looks 
> like stuff caused by the still running dhcp client), and then a continuous 
> stream of segfaults on the restore script itself (restore[1]).

This sounds almost like the pxe/boot code is still using ram that the
kernel has now used (eg the PXE layer or pxe booter forgot to close the
client and
its still DMAing happily into the kernel)


