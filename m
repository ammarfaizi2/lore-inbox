Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271044AbTGQCZb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271333AbTGQCZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:25:31 -0400
Received: from host.atlantavirtual.com ([209.239.35.47]:19135 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S271044AbTGQCZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:25:30 -0400
Subject: Re: Partitioned loop device..
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Josh Litherland <josh@emperorlinux.com>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030715155317.317B461FDE@sade.emperorlinux.com>
References: <20030715155317.317B461FDE@sade.emperorlinux.com>
Content-Type: text/plain
Organization: 
Message-Id: <1058409892.4211.29.camel@thong>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Jul 2003 22:44:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh

coming in late on this thread, hope I'm not showing my better half.

You may want to look at the work NASA has done on their enhanced
loopback driver;

ftp://ftp.hq.nasa.gov/pub/ig/ccd/enhanced_loopback/

Allows you to take a physical image of a device (such as one created by
'dd') and mount the logical volumes contained within, even if starting
FS code is beyond the 2GB puke limit.   It will mount the volumes 'ro'
for you.

However, be careful if you need true 'ro' on the reiserfs and ext3
filesystems.  So far in our testing mounting these 'ro' via loop device
files (/dev/loop0, etc.) *fails*.  The journal count *is* incremented on
the 'ro' filesystem and writes *can* still occur.

cheers!

farmerdude


On Tue, 2003-07-15 at 11:53, Josh Litherland wrote:
> In article <200307151001.44218.kevcorry@us.ibm.com> you wrote:
> 
> > so there's not much of a reason to add partitioning support to the loop 
> > driver itself.
> 
> Working with sector images of hard drives?  I use Linux for data
> recovery jobs and it would be very helpful to me to be able to look at
> DOS partitions inside a loopback device.  As it is I must chunk it up
> into seperate files by hand.

