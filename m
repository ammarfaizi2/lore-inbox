Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVBCAgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVBCAgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVBCAeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:34:24 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:9992 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262473AbVBCAdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:33:42 -0500
Date: Thu, 3 Feb 2005 01:33:34 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Joe User DOS kills Linux-2.6.10
Message-ID: <20050203003334.GA5680@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 01:23:43PM -0500, linux-os wrote:
> 
> When I compile and run the following program:
> 
> #include <stdio.h>
> int main(int x, char **y)
> {
>     pause();
> }
> ... as:
> 
> ./xxx `yes`
> 
> ... the following occurs after about 30 seconds (your mileage
> may vary):
> 
> Additional sense: Peripheral device write fault
> end_request: I/O error, dev sdb, sector 34605780
> SCSI error : <0 0 1 0> return code = 0x8000002
> Info fld=0x2100101, Deferred sdb: sense key Medium Error
> Additional sense: Peripheral device write fault
> end_request: I/O error, dev sdb, sector 34603748
> SCSI error : <0 0 1 0> return code = 0x8000002
> Info fld=0x2100103, Deferred sdb: sense key Medium Error

When I run "sleep `yes`" under bash, all of swap space is filled,
and then bash says "realloc error ..." and exits.

No kernel problem, no bad bash problem.

If you do not run vm overcommit mode 2 then probably your bash
will be killed by the OOM killer, and if you are unlucky some
other stuff might be killed as well.

Concerning the SCSI errors, looks like you might have disk problems.
Bad blocks in your swap space. Recheck the disk.

Andries
