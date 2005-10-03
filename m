Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVJCPe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVJCPe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVJCPe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:34:26 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:56539 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932298AbVJCPe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:34:26 -0400
Date: Mon, 3 Oct 2005 17:34:19 +0300
From: Ville Herva <vherva@vianova.fi>
To: subbie subbie <subbie_subbie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3Ware 9500S-12 RAID controller -- poor performance
Message-ID: <20051003143419.GF24760@viasys.com>
Reply-To: vherva@vianova.fi
References: <20050930065058.84446.qmail@web30315.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930065058.84446.qmail@web30315.mail.mud.yahoo.com>
X-Operating-System: Linux herkules.vianova.fi 2.4.27
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 11:50:58PM -0700, you [subbie subbie] wrote:
> Dear list,
> 
> After almost two weeks of experimentation, google
> searches and reading of posts, bug reports and
> discussions I'm still far from an answer.  I'm hoping
> someone on this list could shed some light on the
> subject.

Hi,

We're having similar problems with 9500S-4LP and two Hitachi 250GB SATA
disks. 

Currently we are running 2.6.12.5 and its 3w-9xxx driver. We have tried
numerous 2.4 (Red Hat and kernel.org) and 2.6 kernels and 3w-9xxx drivers
(kernel and 3ware.com). 

The results it more or less the same: on 2.4 it corrupts data and is slow,
on 2.6 it doesn't corrupt data, but is slow.

Our workload is VMWare GSX server. Multiple readers/writers will grind the
performance to halt.

We've tried:
 
-     http://216.239.59.104/search?q=cache:08R-x7y-Kn8J:xn.pinkhamster.net/blog/tech/3ware_9500_notes.html+blockdev+stra+3w-9xxx&hl=en
      http://www.linux-mag.com/index2.php?option=com_content&task=view&id=2033&Itemid=2304&pop=1&page=0

             blockdev -setra 16384 /dev/sda

-     different kernel IO schedulers

-     parameters such as
                blockdev --setra 8192 /dev/vg0/root 
                echo 300 > /sys/block/sda/queue/iosched/read_expire 
                echo 5 > /sys/block/sda/queue/iosched/writes_starved

None of this seems to make much difference.

Please drop me a note if you ever get any light on this issue...




-- v -- 

v@iki.fi

