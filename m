Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbULLUiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbULLUiT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbULLUiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:38:19 -0500
Received: from bristol.swissdisk.com ([65.207.35.130]:49045 "EHLO
	bristol.swissdisk.com") by vger.kernel.org with ESMTP
	id S262111AbULLUiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:38:02 -0500
Date: Sun, 12 Dec 2004 14:34:52 -0500
From: Ben Collins <bcollins@debian.org>
To: Arne Caspari <arnem@informatik.uni-bremen.de>
Cc: Dan Dennedy <dan@dennedy.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       Daniel Drake <dsd@gentoo.org>, Christoph Hellwig <hch@lst.de>,
       Adrian Bunk <bunk@stusta.de>, Damien Douxchamps <ddouxcha@is.naist.jp>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Jesper Juhl <juhl-lkml@dif.dk>, Philippe De Muyter <phdm@macqel.be>,
       linux-kernel@vger.kernel.org
Subject: Re: linux1394 patches merged
Message-ID: <20041212193452.GB18851@phunnypharm.org>
References: <1102556231.3714.14.camel@kino.dennedy.org> <41B94A27.2010801@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B94A27.2010801@informatik.uni-bremen.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since neither "raw1394" nor "video1394" are drivers specific to the 
> devices they define matches for, no other ( specialized ) driver can 
> ever get a device object. I am developing a v4l2 driver for the IIDC 
> cameras which is based on the "video-2-1394" driver which again is 
> designed around the device object and the callbacks of the ieee1394 bus 
> driver. This driver never gets loaded since "raw1394" is the first match 
> for the device signature and I had to patch "raw1394" and "video1394" 
> not to match on anything.

Maybe we need some sort of priority for device matching, or maybe a
"generic" to "specific" probing model.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
