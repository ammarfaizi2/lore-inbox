Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282687AbRK0AIm>; Mon, 26 Nov 2001 19:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282672AbRK0AIf>; Mon, 26 Nov 2001 19:08:35 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:58108 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282688AbRK0AG4>;
	Mon, 26 Nov 2001 19:06:56 -0500
Date: Mon, 26 Nov 2001 17:06:31 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: Steve Brueggeman <xioborg@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011126170631.O730@lynx.no>
Mail-Followup-To: Martin Eriksson <nitrax@giron.wox.org>,
	Steve Brueggeman <xioborg@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011124103642.A32278@vega.ipal.net> <20011124184119.C12133@emma1.emma.line.org> <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de> <4.3.2.7.2.20011124150445.00bd4240@10.1.1.42> <3C002D41.9030708@zytor.com> <0f050uosh4lak5fl1r07bs3t1ecdonc4c0@4ax.com> <002f01c176d4$f79a3f70$0201a8c0@HOMER>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <002f01c176d4$f79a3f70$0201a8c0@HOMER>; from nitrax@giron.wox.org on Tue, Nov 27, 2001 at 12:49:19AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 27, 2001  00:49 +0100, Martin Eriksson wrote:
> I sure think the drives could afford the teeny-weeny cost of a power failure
> detection unit, that when a power loss/sway is detected, halts all
> operations to the platters except for the writing of the current sector.

What happens if you have a slightly bad power supply?  Does it immediately
go read only all the time?  It would definitely need to be able to
recover operations as soon as the power was "normal" again, even if this
caused basically "sync" I/O to the disk.  Maybe it would be able to
report this to the user via SMART, I don't know.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

