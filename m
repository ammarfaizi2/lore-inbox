Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTFCF56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 01:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTFCF56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 01:57:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25548 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264937AbTFCF55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 01:57:57 -0400
Date: Mon, 02 Jun 2003 23:09:29 -0700 (PDT)
Message-Id: <20030602.230929.23036776.davem@redhat.com>
To: miles.lane@attbi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk7 -- drivers/net/irda/w83977af_ir.ko needs unknown
 symbol setup_dma
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EDC3B52.6030604@attbi.com>
References: <3EDBCC44.8000009@attbi.com>
	<1054612898.9352.3.camel@rth.ninka.net>
	<3EDC3B52.6030604@attbi.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Miles Lane <miles.lane@attbi.com>
   Date: Mon, 02 Jun 2003 23:08:18 -0700

   David S. Miller wrote:
   > On Mon, 2003-06-02 at 15:14, Miles Lane wrote:
   > 
   >>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.70-bk7; fi
   >>WARNING: /lib/modules/2.5.70-bk7/kernel/drivers/net/irda/w83977af_ir.ko 
   >>needs unknown symbol setup_dma
   > What platform is this?  It needs to set CONFIG_ISA correctly.
   
   It's PPC.
 ...   
   # CONFIG_ISA is not set
   
Then it shouldn't allow you to build the w83977af_ir driver.
CONFIG_ISA=y is necessary for this device.
