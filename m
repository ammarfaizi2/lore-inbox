Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290487AbSAQWPY>; Thu, 17 Jan 2002 17:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290488AbSAQWPO>; Thu, 17 Jan 2002 17:15:14 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:36364 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S290487AbSAQWPA>;
	Thu, 17 Jan 2002 17:15:00 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Thu, 17 Jan 2002 14:14:58 -0800
To: Guillaume Boissiere <boissiere@mediaone.net>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 17, 2001
Message-ID: <20020117141458.A11402@vato.org>
In-Reply-To: <3C463337.24593.CD1AD57@localhost> <20020117214752.GA5085@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020117214752.GA5085@localhost>; from jdomingo@internautas.org on Thu, Jan 17, 2002 at 10:47:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if any of the block changes already include this or if
this will rekindle the flamewar on devfs, but something's going to need
to happen with device naming.

At the very least the upcoming change to the major/minor allocation
will allow large numbers of block devices and fs/partitions/check.c's
disk_name() will break.  I think a lot of the scsi code's ready to support
a large number of devices.  It'd be kind of ugly to have it find them
and disk_name() give them colliding names or names with odd extended
characters.

There's already code out there to allow the sd to find more than 128
devices and I've seen it in use where there are enough luns to cause
disk_name() to call them interesting names.

Tim
-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
