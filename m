Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275752AbRJYRIg>; Thu, 25 Oct 2001 13:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273976AbRJYRIY>; Thu, 25 Oct 2001 13:08:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17937 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273904AbRJYRIO>; Thu, 25 Oct 2001 13:08:14 -0400
Subject: Re: Kernel PCMCIA
To: weber@nyc.rr.com (John Weber)
Date: Thu, 25 Oct 2001 18:15:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD843DE.6FD5AF2D@nyc.rr.com> from "John Weber" at Oct 25, 2001 12:54:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wo67-0005T6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why are hotplug and cardmgr needed?  As I understand it, cardbus uses
> hotplug for config/init, and other pcmcia cards use cardmgr for init and
> /etc/pcmcia/* for config.  This seems like a big, smelly mess.

It is in user space because
	o	It is possible to put it in user space
	o	The mappings can be complex and are best done in userspace
	o	User space is best positioned to make further complex
		decisions
	o	User space is best positioned to run scripts/tools as needed
		on a hot plug event

