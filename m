Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272162AbRHVXvn>; Wed, 22 Aug 2001 19:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272164AbRHVXvd>; Wed, 22 Aug 2001 19:51:33 -0400
Received: from web13103.mail.yahoo.com ([216.136.174.148]:2831 "HELO
	web13103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272162AbRHVXvT>; Wed, 22 Aug 2001 19:51:19 -0400
Message-ID: <20010822235135.44493.qmail@web13103.mail.yahoo.com>
Date: Wed, 22 Aug 2001 16:51:35 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [PATCH,RFC] make ide-scsi more selective
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The real problem is that the drivers are claiming
> resources on load not
> on open. Why shouldnt I be able to load ide-cd and
> ide-scsi and open either
> /dev/hda or /dev/sr0 but not both together ? 

What about kernels that use devfs? To open the device,
devfs would need to have already created the device
node, and this must surely happen when the module
loads. Can devfs create a node without claiming any
resources?

For reference, I use devfs, and have a DVD-ROM (hdc)
and a CD burner (hdd). The DVD uses ide-cd and the
burner uses ide-scsi, and I have to preload ide-cd
(with the "ignore=hdd" parameter) so that ide-scsi
doesn't grab the DVD.

Chris




__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
