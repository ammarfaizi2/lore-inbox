Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTEPACm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTEPACl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:02:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36264 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264289AbTEPACk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:02:40 -0400
Date: Thu, 15 May 2003 17:14:57 -0700 (PDT)
Message-Id: <20030515.171457.02279102.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305152020.h4FKKfGi014696@locutus.cmf.nrl.navy.mil>
References: <20030515.131021.104054490.davem@redhat.com>
	<200305152020.h4FKKfGi014696@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Thu, 15 May 2003 16:20:41 -0400

   i suspect atm doesnt use rtnl because its register/unregister
   function dont use the underlying netdevice layer (when perhaps it
   should).

There is no correlation between whether you use netdevice or not
and whether network configuration changes should be synchronized
using the RTNL semaphore :-)

   thanks for the pointer.
   
No problem.

   here is the the atm_dev locking patch with the __module_get change:
   
Ok, I'll apply this.  But long term we really need to clean out
the cobwebs here, use RTNL, do solid module refcounting etc.
