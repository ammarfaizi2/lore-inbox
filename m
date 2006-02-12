Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWBLKxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWBLKxK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 05:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWBLKxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 05:53:10 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:43441 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1750839AbWBLKxJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 05:53:09 -0500
X-ME-UUID: 20060212105302469.0B6F71C00142@mwinf0612.wanadoo.fr
From: Vincent ETIENNE <ve@vetienne.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: BUG at drivers/net/dl2k.c
Date: Sun, 12 Feb 2006 11:52:55 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200602092101.41970.ve@vetienne.net> <20060211195718.GA24012@electric-eye.fr.zoreil.com>
In-Reply-To: <20060211195718.GA24012@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602121152.55537.ve@vetienne.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Samedi 11 Février 2006 20:57, Francois Romieu a écrit :
> Vincent ETIENNE <ve@vetienne.net> :
> > I'm using 2.6.14-mm2 kernel (x86_64) on a Bi-Opteron 246 board with a  
> > PCI-64 card ( DLINK 550 GT ) plug  on PCI-X interface. This card use the
> > DL2000 driver which seems to cause this problem logged during boot time 
> > :
> >
> > BUG: warning at drivers/net/dl2k.c:1481/mii_wait_link()
>
> [...]
>
> Try the bandaid below. If it is not enough, please open a PR at
> http://bugzilla.kernel.org and add me to the Cc: list.
>
> 1ms delay in irq context always hurt. This stuff should be done in
> an user-context.
>
>

With your change, everything is ok now. No more BUG in dmesg :).

Many thanks for your help. 

	Vincent

