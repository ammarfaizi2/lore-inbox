Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVFALtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVFALtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVFALtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:49:00 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:29971 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261337AbVFALs6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:48:58 -0400
Message-ID: <429DA0A9.6010808@rtr.ca>
Date: Wed, 01 Jun 2005 07:48:57 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl>
In-Reply-To: <429BA001.2030405@keyaccess.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look at "cat /proc/interrupts" and see if the USB is sharing
an IRQ line with ide0.  If so, then the best explanation I can
see is that the USB driver must have a *really slow* interrupt
handler up to the point where it determines that the interrupt
is not for it.

-ml
