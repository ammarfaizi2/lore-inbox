Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTEOT6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTEOT6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:58:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14502 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264226AbTEOT6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:58:02 -0400
Date: Thu, 15 May 2003 13:10:21 -0700 (PDT)
Message-Id: <20030515.131021.104054490.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305151439.h4FEdQGi012649@locutus.cmf.nrl.navy.mil>
References: <20030514.213014.91331736.davem@redhat.com>
	<200305151439.h4FEdQGi012649@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Thu, 15 May 2003 10:39:26 -0400
   
   any other ideas or preferences?
   
Hold the RTNL semaphore when making any changes, therefore
you know no items can be removed/added while you hold this
semaphore.

I mean, this is the most fundamental part of how the networking
locks configuration changes, I'm actually baffled that ATM
doesn't make use of it :-(

Please, look at how netdevice objects are managed.
