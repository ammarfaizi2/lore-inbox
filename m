Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVAKHIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVAKHIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 02:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVAKHIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 02:08:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45253 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262398AbVAKHIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 02:08:11 -0500
Date: Tue, 11 Jan 2005 08:08:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Laurent CARON <lcaron@apartia.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
In-Reply-To: <41E2F823.1070608@apartia.fr>
Message-ID: <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr>
References: <41E2F823.1070608@apartia.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
> I recently upgraded to 2.6.10 and tried (today) to burn a dvd with growisofs.
>
> It seems there is a problem
>
> Here is the output
>
>
> # growisofs -Z /dev/scd0 -R -J ~/foobar

I remember ide-scsi being broken now since you can use /dev/hdX directly for 
writing CDs.

> WARNING: /dev/scd0 already carries isofs!
> About to execute 'mkisofs -R -J /root/sendmail.mc | builtin_dd of=/dev/scd0
> obs=32k seek=0'
> INFO:ingISO-8859-15 character encoding detected by locale settings.
> Assuming ISO-8859-15 encoded filenames on source filesystem,
> use -input-charset to override.
> Total translation table size: 0
> Total rockridge attributes bytes: 252
> Total directory bytes: 0
> Path table size(bytes): 10
> /dev/scd0: "Current Write Speed" is 4.1x1385KBps.
> : -[ WRITE@LBA=0h failed with SK=4h/ASC=08h/ACQ=03h]: Input/output error
> : -( write failed: Input/output error
>
> Needless to say it works fine with 2.6.9
> Am I missing something?

/dev/hdX of course won't work if ide-scsi is loaded, I guess.



Jan Engelhardt
-- 
ENOSPC
