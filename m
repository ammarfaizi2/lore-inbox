Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVBNMZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVBNMZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 07:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVBNMZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 07:25:31 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:63415 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261422AbVBNMZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 07:25:28 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] drivers/connector/connector.c: remove
	dead code
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: johnpol@2ka.mipt.ru, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1108382512.16745.36.camel@frecb000711.frec.bull.fr>
References: <1108382512.16745.36.camel@frecb000711.frec.bull.fr>
Date: Mon, 14 Feb 2005 13:25:24 +0100
Message-Id: <1108383924.16745.37.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/02/2005 13:34:08,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/02/2005 13:34:11,
	Serialize complete at 14/02/2005 13:34:11
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 13:01 +0100, Guillaume Thouvenin wrote:
> This patch removes unreachable code in cn_netlink_send() function.

The code can be reach via  
nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh));

So the patch is wrong
Sorry for that

Guillaume

