Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbVAJWmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVAJWmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbVAJWkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:40:02 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:42880 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262550AbVAJW3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:29:30 -0500
Date: Mon, 10 Jan 2005 17:29:26 -0500
To: Laurent CARON <lcaron@apartia.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
Message-ID: <20050110222926.GA17865@csclub.uwaterloo.ca>
References: <41E2F823.1070608@apartia.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E2F823.1070608@apartia.fr>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:48:19PM +0100, Laurent CARON wrote:
> I recently upgraded to 2.6.10 and tried (today) to burn a dvd with 
> growisofs.
> 
> It seems there is a problem
> 
> Here is the output
> 
> 
> # growisofs -Z /dev/scd0 -R -J ~/foobar
> 
> WARNING: /dev/scd0 already carries isofs!
> About to execute 'mkisofs -R -J /root/sendmail.mc | builtin_dd 
> of=/dev/scd0 obs=32k seek=0'
> INFO:ingISO-8859-15 character encoding detected by locale settings.
>        Assuming ISO-8859-15 encoded filenames on source filesystem,
>        use -input-charset to override.
> Total translation table size: 0
> Total rockridge attributes bytes: 252
> Total directory bytes: 0
> Path table size(bytes): 10
> /dev/scd0: "Current Write Speed" is 4.1x1385KBps.
> :-[ WRITE@LBA=0h failed with SK=4h/ASC=08h/ACQ=03h]: Input/output error
> :-( write failed: Input/output error
> 
> 
> Needless to say it works fine with 2.6.9
> 
> Am I missing something?

Is it actually a scsi device?

I haven't tried myself with 2.6.10 yet, but with 2.6.9 and older I have
just used /dev/hda to access my dvd writer.  Seemed much better than
ide-scsi at least.  Of course if it is usb or firewire I guess the scsi
interface is required.

Len Sorensen
