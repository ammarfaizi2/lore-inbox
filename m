Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVGNXuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVGNXuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVGNXuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:50:08 -0400
Received: from taxbrain.com ([64.162.14.3]:64053 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S261720AbVGNXuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:50:06 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9 chrdev_open: serial_core: uart_open
Date: Thu, 14 Jul 2005 16:50:00 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILMEAJCEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20050714195717.B10410@flint.arm.linux.org.uk>
X-Spam-Processed: petzent.com, Thu, 14 Jul 2005 16:46:14 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Thu, 14 Jul 2005 16:46:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrdev_open issues a lock_kernel() before calling uart_open.

It would appear that servicing the blocking open request uart_open goes to
sleep with the kernel locked.  Would this shut down subsequent access to
opening "/dev/tty"???

karl m



