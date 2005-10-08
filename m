Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVJHQDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVJHQDf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 12:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVJHQDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 12:03:35 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:44942 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S932162AbVJHQDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 12:03:34 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
Date: Sat, 8 Oct 2005 17:03:32 +0100
User-Agent: KMail/1.8.2
Cc: Gordon Henderson <gordon@drogon.net>, linux-raid@vger.kernel.org
References: <200510071111.46788.andrew@walrond.org> <200510081555.41159.andrew@walrond.org> <Pine.LNX.4.56.0510081600080.7326@lion.drogon.net>
In-Reply-To: <Pine.LNX.4.56.0510081600080.7326@lion.drogon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081703.32873.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gordon,

On Saturday 08 October 2005 16:23, Gordon Henderson wrote:
> On Sat, 8 Oct 2005, Andrew Walrond wrote:
> > On Saturday 08 October 2005 15:26, Molle Bestefich wrote:
> > > IDE hotswap has never worked (OOTB at least) in Linux, and based on my
>
> Ideally you want hardware that will power the drive down nicely before you
> take it out (and power it up nicely after you plug it back in again) to
> avoid any glitches on the SCSI bus, etc...

Sounds hairy! Are you aware of any linux scsi drivers which support this 
powering up/down, via /proc or some userspace tools perhaps?

>
> One thing to watch out for - if you reboot after taking the drive out the
> scsi drive letters will be logically renumbered, so if you take out sda,
> then reboot, what was sdb will now become sda, and so on, so if you then
> subsequently hot plug a drive in, it will still have the same scsi host,
> channel, id, lun numbers, but it'll be the last device in the array (eg.
> it will be sdf if it was a 6-disk array) Reboot again and the original
> numbering/lettering would be restored.
>
> Good job the RAID code doesn't really care about this...

Indeed. Linux raid is very fine. If we can just fixup this hotplug weakness, 
it would be peerless.

>
> Good luck!
>

Thanks, and good to hear from you ;)

Andrew
