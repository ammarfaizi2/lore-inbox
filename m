Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSFSLoD>; Wed, 19 Jun 2002 07:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317854AbSFSLoC>; Wed, 19 Jun 2002 07:44:02 -0400
Received: from ns.suse.de ([213.95.15.193]:60423 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317855AbSFSLoB>;
	Wed, 19 Jun 2002 07:44:01 -0400
Date: Wed, 19 Jun 2002 13:44:02 +0200
From: Dave Jones <davej@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/partitions broken in 2.5.23
Message-ID: <20020619134402.B29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andries Brouwer <aebr@win.tue.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619090248.GA8681@suse.de> <20020619113233.GA15730@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020619113233.GA15730@win.tue.nl>; from aebr@win.tue.nl on Wed, Jun 19, 2002 at 01:32:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 01:32:33PM +0200, Andries Brouwer wrote:

 > >   22     0 1515870810 hdc
 > >   22    64 1515870810 hdd
 > >    3     0   29316672 hda
 > >    3     1     117400 hda1
 > >    3     2          1 hda2
 > >    3     5     999904 hda5
 > >    3     6    1499872 hda6
 > >    3     7     683392 hda7
 > >    3     8   26015944 hda8
 > >    3    64 1515870810 hdb
 > I changed something here a few weeks ago. The idea was to avoid
 > listing partitions of size 0 but do list full devices, regardless
 > of size. Especially in case of removable media that is useful.
 > For example, a
 > 	blockdev --rereadpt /dev/sda
 > might show that there is something there now.

Seems it doesn't handle the case of 'no media in drive' too well.
hdc - cdrom, hdd - zip drive, hdb - no device there.

hda2 is odd looking too showing a #blocks of '1', when
it's actually..

   Device Boot    Start       End    Blocks   Id  System
/dev/hda2           234     58168  29199240    5  Extended 


Oddly, on another machine, it detects an LS-120 drive with
no media correctly..
  22    64          0 hdd

(but still gets the 'no device' case wrong on that box).

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
