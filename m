Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271592AbRIOADn>; Fri, 14 Sep 2001 20:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRIOADe>; Fri, 14 Sep 2001 20:03:34 -0400
Received: from gear.torque.net ([204.138.244.1]:21764 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S271592AbRIOAD3>;
	Fri, 14 Sep 2001 20:03:29 -0400
Message-ID: <3BA299D7.55F6C2D6@torque.net>
Date: Fri, 14 Sep 2001 19:59:19 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph Cheek <joseph@cheek.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2 IDE cd-roms + ide-scsi = 4 scsi cdroms ???
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Cheek <joseph@cheek.com> wrote:
> i added a second ide cdrom to this system and now notice that i have 
> four scsi cdroms show up.  really weird.  this was on 2.4.7-ac10 and 
> repros on 2.4.9-ac10.
> 
> when i had one cdrom (/dev/hdc) i had just one scsi cdrom after loading 
> ide-scsi (/dev/sr0).

Joseph,
Try turning off CONFIG_SCSI_MULTI_LUN in your kernel
config and recompile your kernel (or modules in your case
because lsmod shows all your scsi components are modules).

This will stop 2 luns being seen for each actual
device.

Doug Gilbert
