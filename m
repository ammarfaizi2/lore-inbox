Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVI2QaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVI2QaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVI2QaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:30:07 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:7841 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932167AbVI2QaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:30:05 -0400
Date: Thu, 29 Sep 2005 12:30:05 -0400
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Temporary workaround for stuck CD burner
Message-ID: <20050929163005.GB20178@csclub.uwaterloo.ca>
References: <20050929160006.GA19550@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929160006.GA19550@kestrel>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 06:00:07PM +0200, Karel Kulhavy wrote:
> I managed to turn off the DVD burner by suspending the laptop to disk
> and reviving.

Well that would turn off and on power and reset the drive just as a
reboot would have.

> Now the command
> cdrecord -tao dev=ATAPI:0,0,0 speed=8 /home/clock/cdrom.iso
> is behaving like in those good olden days before Linux kernel seizure.
> 
> More information: dmesg reveals that during the seizure, no dmesg
> messages were generated (no SCSI errors/timeouts etc.).
> 
> When mounting the first badly burned CD, SCSI errors were generated.
> Last 3 of them:
> 
> hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete
> Error }
> hdc: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
> ide: failed opcode was: unknown
> end_request: I/O error, dev hdc, sector 8
> printk: 2 messages suppressed.
> Buffer I/O error on device hdc, logical block 1
> hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete
> Error }
> hdc: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
> ide: failed opcode was: unknown
> end_request: I/O error, dev hdc, sector 16
> hdc: media error (bad sector): status=0x51 { DriveReady SeekComplete
> Error }
> hdc: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
> ide: failed opcode was: unknown
> end_request: I/O error, dev hdc, sector 0

Those are normal messages meaning 'can not read this disc'.  Usually
means incomplete or bad burn.

Len Sorensen
