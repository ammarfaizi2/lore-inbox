Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292372AbSBYWip>; Mon, 25 Feb 2002 17:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292363AbSBYWha>; Mon, 25 Feb 2002 17:37:30 -0500
Received: from web21303.mail.yahoo.com ([216.136.129.192]:7297 "HELO
	web21303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292370AbSBYWgB>; Mon, 25 Feb 2002 17:36:01 -0500
Message-ID: <20020225223600.88950.qmail@web21303.mail.yahoo.com>
Date: Mon, 25 Feb 2002 14:36:00 -0800 (PST)
From: Christine Ames <clgisotti@yahoo.com>
Subject: RE: [PATCH] block_dev.c: fsync() on close() considered harmful
To: post linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig [hch@caldera.de] wrote:
> Hi Alan,
> 
> I don't see any standard specifying that fsync should be done on
> every blockdevice close.
> 
> Any chance you could add the below patch to the next -ac release?
> 
> 	Christoph

I am writing a partitionable block device driver for the 2.4 kernel.
Once the driver is loaded and the device mounted, reading, writing,
and ioctls work properly.

The driver becomes unstable after many mounts/unmounts, and I have
come to suspect that I am not calling fsync_dev() correctly.

I do call fsync_dev() on release as well as on remove.
Is this incorrect?  Can it lead to instability?  I've counted four
different ways in which the driver dies, including a call to 
BUG() in buffer.c...

Thank you,

Christine


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
