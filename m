Return-Path: <linux-kernel-owner+w=401wt.eu-S965282AbXAKAx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbXAKAx3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbXAKAx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:53:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:20643 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965282AbXAKAx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:53:29 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XLS+3vJtqYf/poNW6FH3dcf7LdQfpV0Qu3eM0DUYixC4KJ/SMEZtzsbXvO+pWS3B+7jUO+IPEXXWPuG8c+sWCOIwn91K96pBE3igaMmH6svejOTIQikczUrU9yeZY9b5YHe4fohs9e4XhfFxzzHUe1v+p3ONOYQ2r4SZWckpT9A=
Message-ID: <948ae28c0701101653n572d0c63n2145e9b4208a6e5b@mail.gmail.com>
Date: Wed, 10 Jan 2007 17:53:28 -0700
From: "meaty biscuit" <meatybiscuit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: DMA problems in ide-scsi
In-Reply-To: <948ae28c0701101559j1e750d61g1f810feb04c1c4fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <948ae28c0701101559j1e750d61g1f810feb04c1c4fb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know there are lots of people that are glad to be done with
ide-scsi, but I'm hoping there is someone out there that has some
experience with this driver that my be able to help.  I would happily
switch modules and start using ide-cd, but I have a few pieces of
software that rely on ide-scsi to work properly and I don't have
enough time to change my software to work with ide-cd before my
product release deadline.

I am working with a mainline kernel, version 2.6.15.7 (I cannot change
kernel versions either).  If DMA is enabled and I try to write to a
CD, I get a kernel panic.  However, reading from a CD with DMA enabled
works fine.  If DMA is disabled and programmed IO is used, I can both
read and write CDs but the fact that PIO uses so much of the CPU
causes my application to have some problems and again, I don't have
time to go through several application release cycles to make them
work with PIO.

I have noticed that writing to CD (with DMA enabled) in 2.6.9 works
fine, it seems as though the breakage of ide-scsi occured in 2.6.10.
Also, burning a CD using DMA with ide-scsi in 2.6.19 seems to work as
well.  I have looked through the ide-scsi code for hours, and I have
also done a fair amount of debugging looking for the problem but I
have had no success.  I tried contacting Bartlomiej and have been
unsuccessful in getting a hold of him.  Does anyone know of a patch
floating around that may fix this problem?  Does anyone that is more
familiar with the ide, scsi, or dma subsystems have any suggestions
for me?  I am willing to put in the time and effort to fix this
problem and I would be more than happy to submit a fix back into the
open source world, but I am stuck and need any help I can get.

Thanks for your time.
