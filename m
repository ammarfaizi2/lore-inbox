Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRBAQuL>; Thu, 1 Feb 2001 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129579AbRBAQuB>; Thu, 1 Feb 2001 11:50:01 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:49677 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129268AbRBAQt5>; Thu, 1 Feb 2001 11:49:57 -0500
Date: Thu, 01 Feb 2001 11:49:49 -0500
From: Chris Mason <mason@suse.com>
To: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs min size (was: [2.4.1] mkreiserfs on loopdevice freezes kernel)
Message-ID: <432150000.981046189@tiny>
In-Reply-To: <20010131232757.A23675@lina.inka.de>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 31, 2001 11:27:57 PM +0100 Bernd Eckenfels <ecki@lina.inka.de> wrote:

> On Wed, Jan 31, 2001 at 09:24:39AM +0000, James Sutherland wrote:
>> 32 megaBLOCK?? How big is it in Mbytes?
> 
> Blocksize is 4k, mkreiserfs in my version is telling me it can not generate
> partitions smaller than 32M but it is not true, i have to do
> 
> dd if=/dev/zero of=/var/loop.img count=32768 size=4096
> 
>> You do know reiserfs defaults to
>> building a 32 Mbyte journal on the device, I take it?
> 
> Yes, I wonder if it is a Error in mkreiserfs to require 128MB.

It is.  The actual min is around 40MB (with 32MB used by the journal.  Next version of mkreiserfs will be fixed.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
