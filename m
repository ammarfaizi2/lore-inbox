Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUAEEeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbUAEEeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:34:37 -0500
Received: from hurricane.skynet.be ([195.238.2.86]:5305 "EHLO
	hurricane.skynet.be") by vger.kernel.org with ESMTP id S262683AbUAEEef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:34:35 -0500
Subject: Problem in usb_driver_release_interface ( drivers/usb/core/usb,c )
	in 2.6.X kernel
From: Desmecht Laurent <l.desmecht@skynet.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1073277290.2074.57.camel@laurent.publikot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 05:34:51 +0100
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (hurricane.skynet.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with recent linux kernels ( 2.6.X ), the user-space driver of the
speedtouch usb modem don't work, after some experimentations I was able
to find a solution :
If I comment the call to the function:

usb_set_interface(interface_to_usbdev(iface),
			iface->altsetting[0].desc.bInterfaceNumber,
			0);

in usb_driver_release_interface (drivers/usb/core/usb,c)

( as it was in kernel before 2.6.0-test2-bk2 )
then the modem work fine, without any problem.

Can a Linux kernel developer explain this and try fix this in the
official kernel?

Thanks,
Laurent Desmecht


