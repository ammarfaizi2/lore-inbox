Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSIDXmV>; Wed, 4 Sep 2002 19:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSIDXmV>; Wed, 4 Sep 2002 19:42:21 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:9806 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S316545AbSIDXmT>;
	Wed, 4 Sep 2002 19:42:19 -0400
Date: Thu, 5 Sep 2002 01:46:53 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andries.Brouwer@cwi.nl, greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Message-ID: <20020904234653.GB10227@win.tue.nl>
References: <UTC200209042256.g84Mu0w15389.aeb@smtp.cwi.nl> <20020904161042.O13478@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020904161042.O13478@one-eyed-alien.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 04:10:42PM -0700, Matthew Dharm wrote:

> I'm trying to find out why Windows doesn't choke on the strange
> READ_CAPACITY value.

That is an easy one.
It belongs to the recent partitioning discussion on l-k.

Windows knows the type of partition table, so reads the
partition table and the boot sector and the FAT and is happy.

Linux tries various things, depending on how you compiled your kernel,
and among other things also needs to examine the last sector.
So, only Linux will do bad things in case the capacity is off by one,
and only when your config includes partitioning types that use this
last sector.


Andries

