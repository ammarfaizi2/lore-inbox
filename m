Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbTCITh5>; Sun, 9 Mar 2003 14:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbTCITgz>; Sun, 9 Mar 2003 14:36:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37302
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262593AbTCITgA>; Sun, 9 Mar 2003 14:36:00 -0500
Subject: Re: New IDE codes in 2.5.64-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030309021615.GB981@yuzuki.cinet.co.jp>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
	 <20030309021615.GB981@yuzuki.cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047243193.6397.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 09 Mar 2003 20:53:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 02:16, Osamu Tomita wrote:
> My PC98 box doesn't boot 2.5.64-ac3.
> After print "ide-default: hdd: Failed to register the driver with ide.c"
> forced to panic.
> "hdd" is not connected my box.
> IMHO We need status meaning 'supported by the driver but drive not present'.
> Or this problem is PC98 specific?

Every device registered should now have a driver in all situations. The 
panic sounds like the pc98 ide might be using ata_attach() directly or
indirectly on a non existant disk. That would upset things

