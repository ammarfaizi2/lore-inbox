Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbUELWqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUELWqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUELWqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:46:37 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42983 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262272AbUELWq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:46:29 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: ppc64 HDIO_TASK_* ioctls 2.4, 2.6
Date: Thu, 13 May 2004 00:47:49 +0200
User-Agent: KMail/1.5.3
References: <200405122209.i4CM9vqS013716@falcon10.austin.ibm.com>
In-Reply-To: <200405122209.i4CM9vqS013716@falcon10.austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405130047.49860.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 of May 2004 00:09, Doug Maxey wrote:
> Howdy,
>
>   I need a some guidance on enabling the ioctls on ppc64 to allow
>   the smartmontools to run the appropriate set of commands.
>
>   Does this look ok?

+COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
+#ifdef CONFIG_IDE_TASK_IOCTL
+COMPATIBLE_IOCTL(HDIO_DRIVE_TASKFILE),
+COMPATIBLE_IOCTL(HDIO_DRIVE_TASK),
+#endif CONFIG_IDE_TASK_IOCTL
 
HDIO_DRIVE_TASK is _always_ available

>   Have sniff tested, and the smart tools do run without ioctl errors.
>
> ++doug

