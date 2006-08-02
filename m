Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWHBHYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWHBHYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWHBHYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:24:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:28021 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751318AbWHBHYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:24:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WMzoIZyItUKC9wgTRoFk3OCAJ0ZZYzPIxV5Xm9vEh9vIywV0iLkpTbJPGBmBbVon0y4l1E/pB66KJWepSS8M7YeshavSjghyYMOKHGM0a1cmNvg49nejobjkjNhzXAPcOEXK9njaAdX39kSgdhIRy0mgRg8TWagIclu7K3Zdb7M=
Message-ID: <6d6a94c50608020024n9d8fbc0tcdedcadeedd54b44@mail.gmail.com>
Date: Wed, 2 Aug 2006 15:24:03 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Newest Serial core issue
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

My platform is using DMA to tx/rx data from UART. It's ok for tx
datapath when I port the driver to the newest serial core framework.
But I found all of the current existing drivers are using
"uart_insert_char" to process the received chars to the high level tty
driver, that means the received chars are processed byte by byte. But
for my case, I need to transfer the received data to the high level
tty driver block by block. Did I miss some API like
"uart_insert_block"?
Or Are there any other way to deal with my case to use the newest serial core?

Thanks for any hints.

Regards,
-Aubrey
