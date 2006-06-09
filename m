Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWFIAlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWFIAlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWFIAlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:41:10 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:22690 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S965052AbWFIAlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:41:05 -0400
Subject: Re: booting without initrd
From: Arjan van de Ven <arjan@infradead.org>
To: Rahul Karnik <rahul@genebrew.com>
Cc: Ram Gupta <ram.gupta5@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com>
References: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
	 <b29067a0606081040q17c66f5bpa966da851635e942@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 02:40:59 +0200
Message-Id: <1149813659.3124.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 13:40 -0400, Rahul Karnik wrote:
> On 6/7/06, Ram Gupta <ram.gupta5@gmail.com> wrote:
> > I am trying to boot with 2.6.16  kernel at my desktop running fedora
> > core 4 . It does not boot without initrd generating the message "VFS:
> > can not open device "804" or unknown-block(8,4)
> > Please append a correct "root=" boot option
> > Kernel panic - not syncing : VFS:Unable to mount root fs on unknown-block(8,4)
> 
> AFAIK Fedora sets up the kernel command line with "root=LABEL=/" in
> grub.conf and therefore needs the initrd in order to work correctly.
> If you do not want an initrd, then change this to
> "root=/dev/<your_disk>" in grub.conf. 

it's more than that; also udev is used from the initrd to populate a
ramfs /dev, if you go without the initrd you need to populate the
*real* /dev manually first

