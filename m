Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319231AbSHUXDO>; Wed, 21 Aug 2002 19:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319237AbSHUXDO>; Wed, 21 Aug 2002 19:03:14 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1115 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S319231AbSHUXDN>; Wed, 21 Aug 2002 19:03:13 -0400
Date: Wed, 21 Aug 2002 19:07:19 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [BK PATCH] Still more USB changes for 2.5.31
Message-ID: <20020821190719.B25260@devserv.devel.redhat.com>
References: <20020821224940.GA3099@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020821224940.GA3099@kroah.com>; from greg@kroah.com on Wed, Aug 21, 2002 at 03:49:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <greg@kroah.com>
> Date: Wed, 21 Aug 2002 15:49:40 -0700

> ChangeSet@1.514, 2002-08-21 13:53:49-07:00, mdharm-usb@one-eyed-alien.net
>   [PATCH] PATCH: fix devices which don't support START_STOP
>   
>   Based on my discussions with Pete Zaitcev <zaitcev@redhat.com>, I'm
>   convinced that globally re-writing the START_STOP command into a
>   TEST_UNIT_READY command is a good idea.  This is supported by the fact
>   that:
>   
>   (1) Lots of devices don't support START_STOP
>   (2) Those that do support it often don't do a good job
>   (3) Win/Mac will never send these commands over a USB bus
>   
>   So, here's a patch that re-writes them into Test Unit Ready commands.

For the record, I do not think the blanket rewrite is a good idea.
I did it for broken devices only, governed by a new quirk flag,
and this is what we currently ship.

Matt reviewed what I did, but decided it would be cleaner
to rewrite commands always. I did not go on a roll against it because:
 1. 2.5 is supposed to be somewhat broken;
 2. Matt is the module maintainer, he knows what he's doing.

-- Pete
