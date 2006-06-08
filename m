Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWFHRkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWFHRkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 13:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWFHRkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 13:40:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:17970 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964920AbWFHRkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 13:40:12 -0400
Message-ID: <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com>
Date: Thu, 8 Jun 2006 13:40:11 -0400
From: "Rahul Karnik" <rahul@genebrew.com>
To: "Ram Gupta" <ram.gupta5@gmail.com>
Subject: Re: booting without initrd
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
In-Reply-To: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/06, Ram Gupta <ram.gupta5@gmail.com> wrote:
> I am trying to boot with 2.6.16  kernel at my desktop running fedora
> core 4 . It does not boot without initrd generating the message "VFS:
> can not open device "804" or unknown-block(8,4)
> Please append a correct "root=" boot option
> Kernel panic - not syncing : VFS:Unable to mount root fs on unknown-block(8,4)

AFAIK Fedora sets up the kernel command line with "root=LABEL=/" in
grub.conf and therefore needs the initrd in order to work correctly.
If you do not want an initrd, then change this to
"root=/dev/<your_disk>" in grub.conf. Note that the reason Fedora uses
the LABEL is so you can move disks around in your system without a
problem, so you should be careful doing so after making the change.

-Rahul
-- 
Rahul Karnik
rahul@genebrew.com
