Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVHONf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVHONf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 09:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVHONf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 09:35:58 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:23561 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S932522AbVHONf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 09:35:57 -0400
Subject: Vendor specific SCSI opcodes
From: Mathieu Fluhr <mfluhr@nero.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Nero AG
Date: Mon, 15 Aug 2005 15:34:08 +0200
Message-Id: <1124112848.1945.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

I have a problem when using vendor-specific SCSI opcodes with the
ide-cdrom drive. Unless I run the CDROM_SEND_PACKET ioctl as root, I am
getting an error.... plus a kernel warning: 
  Aug 10 12:09:08 localhost kernel: scsi: unknown opcode 0xfa

(..and there is not only 0xfa ad opcode ;-)

As far as I have understood the kernel source code, the problem seems to
be related to the verify_command() introduced in 2.6.8. The thing is
that all these vendor-specific opcodes are not inside the 'cmd_type',
and so not 'safe'.
Nice thing is that when I use exactly the same device over an IDE-to-USB
bridge, it is working like a charm ;-)

So is there a way to bypass this command verification and to let the
program work without launching it as root user ?

Best Regards,
Mathieu


