Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSFTRAo>; Thu, 20 Jun 2002 13:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSFTRAn>; Thu, 20 Jun 2002 13:00:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60426 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315375AbSFTRAl>; Thu, 20 Jun 2002 13:00:41 -0400
Date: Thu, 20 Jun 2002 10:01:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@suse.de>
cc: Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <20020620173654.O29373@suse.de>
Message-ID: <Pine.LNX.4.44.0206200959390.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Dave Jones wrote:
>
> Is this the same bug that causes this wierdo..
>
> (davej@mesh:drivers)$ pwd
> /driver/bus/pci/drivers
> (davej@mesh:drivers)$ ls -l
> ls: VIA 82C686A/B: No such file or directory

No, that's a separate issue: a device that has an embedded "/" in the
filename is not something you can look up in a UNIX filesystem.

So drivers should avoid using "/" in their name.

(or driverfs might convert them automatically, although I personally think
we should just avoid them).

		Linus

