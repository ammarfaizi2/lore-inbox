Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUKOX7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUKOX7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUKOX5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:57:12 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:14713 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261675AbUKOX4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:56:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=UmZ8wo/o2e64H1hc34jRk4oax66qpv05JycTKgl158UtEzF60tTRdv9fR4dVDq2t1tPM3qZ5Su/axIvJM3SEahnf9ZssFNnpiK1IlrvEEOyYa3hysXLyxmb8dkRSbFn0wm6Adbt6qqsSXJt7zQm9iRsOmVggswiBu7IDOwGkczg=
Message-ID: <8e93903b04111515567dc162f3@mail.gmail.com>
Date: Mon, 15 Nov 2004 23:56:10 +0000
From: Alan Pope <alan.pope@gmail.com>
Reply-To: Alan Pope <alan.pope@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: DMA & PDC202XX issue
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Via based mobo with Promise PDC20265 controller with a
Seagate ST3200822A disk attached, giving me IO errors whenever I touch
the disk. I'm using the PDC202XX_OLD driver and have forced DMA on. I
have tried 2.6.8 through up to 2.6.9-ac9 and 2.6.10-rc2, all give the
same error. I can easily reproduce it with a simple "hdparm -t -T
/dev/hde" but under "normal" use such as copying files from another
disk on another channel, the same thing happens.

hde: dma_intr: status=0xff { Busy }

ide: failed opcode was: unknown
hde: DMA disabled
PDC202XX: Primary channel reset.
PDC202XX: Secondary channel reset.

(a number of times)

ide2: reset timed-out, status=0xff
end_request: I/O error, dev hde, sector 11776
Buffer I/O error on device hde, logical block 1472

(many times)

Any ideas greatfully received.
I have put some system details at http://www.popey.com/promise.htm if
that helps.

Cheers,
Al.
