Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268112AbTBXFvb>; Mon, 24 Feb 2003 00:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267989AbTBXFvb>; Mon, 24 Feb 2003 00:51:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29923 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268112AbTBXFva>;
	Mon, 24 Feb 2003 00:51:30 -0500
Date: Sun, 23 Feb 2003 21:45:13 -0800 (PST)
Message-Id: <20030223.214513.120185268.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] get skb->len right after adjusting head
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200302240130.h1O1UnWk027874@locutus.cmf.nrl.navy.mil>
References: <200302240130.h1O1UnWk027874@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Sun, 23 Feb 2003 20:30:49 -0500

   when the lane client strips off the lec it should also adjust the length
   of skb 
   
Don't try to modify skb->{data,len} by hands, let the skb_*()
interfaces do it.  Use skb_pull() in this case.

Franks a lot,
David S. Miller
davem@redhat.com
