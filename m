Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTEVWyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTEVWyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:54:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30688 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263373AbTEVWyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:54:11 -0400
Date: Thu, 22 May 2003 16:05:31 -0700 (PDT)
Message-Id: <20030522.160531.59667592.davem@redhat.com>
To: akpm@digeo.com
Cc: mfc@krycek.org, linux-kernel@vger.kernel.org
Subject: Re: Error during compile of 2.5.69-mm8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030522160218.57b828db.akpm@digeo.com>
References: <1053611668.4649.1.camel@krycek>
	<20030522160218.57b828db.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Thu, 22 May 2003 16:02:18 -0700

   Looks like David converted this macro into a no-op, then moved it into
   netdevice.h.
   
   Problem is, some non-network drivers were using it too.
   
They shouldn't, it's backwards compatability crap for net drivers
only.  Use explicit ->owner references elsewhere.

   Maybe we should put it back the way it was and go edit all the netdrivers?
   
Absolutely not.

Yoshfuji posted a patch on linux-kernel to fix this already.
