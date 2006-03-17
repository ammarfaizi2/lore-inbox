Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932741AbWCQUEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbWCQUEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbWCQUEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:04:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10187 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932741AbWCQUEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:04:10 -0500
Date: Fri, 17 Mar 2006 15:02:30 -0500
From: Alan Cox <alan@redhat.com>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: "'Alan Cox'" <alan@redhat.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-usb-devel@lists.sourceforge.net,
       usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, v4l-dvb-maintainer@linuxtv.org,
       mdharm-usb@one-eyed-alien.net
Subject: Re: [usb-storage] Re: [v4l-dvb-maintainer] 2.6.16-rc: saa7134 + u sb-storage = freeze
Message-ID: <20060317200230.GA13144@devserv.devel.redhat.com>
References: <820212CF2FD63647B52A8F64B35352B20B94229B@essomaexc1.essvote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820212CF2FD63647B52A8F64B35352B20B94229B@essomaexc1.essvote.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 09:59:44AM -0600, Ballentine, Casey wrote:
> Attached please find the output of "lspci -vvxxx" using the released 1.05
> BIOS and the 1.05 test BIOS on a VIA EPIA PD-10000 mainboard (CLE266
> northbridge and vt8235 southbridge).  Hopefully this will shed some light on
> what VIA is doing.  Let me know if I can provide more information.

Ok the changes in the PCI space are

82C586_1		:	0x70 was 0x22: now 0x42
8235	(South)		:	0x91 was 0x00 now 0x03
862X	(North)		:	0x61 was 2a now ea 0x62 was 00 now 03 0x68
				was 0xD1 now 0xCA 0x81 was 0x61 now 0x69


8235 0x91 is just general purpose timer control
82C586_1 0x70 is an IDE status bit

So the changes that matter are those (or some of those) on the 862X. Which is
the one bit I don't have docs on

