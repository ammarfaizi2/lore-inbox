Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTBGTwj>; Fri, 7 Feb 2003 14:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbTBGTwi>; Fri, 7 Feb 2003 14:52:38 -0500
Received: from beta.bandnet.com.br ([200.195.133.131]:57352 "EHLO
	beta.bandnet.com.br") by vger.kernel.org with ESMTP
	id <S266615AbTBGTwh>; Fri, 7 Feb 2003 14:52:37 -0500
From: "User &" <breno_silva@beta.bandnet.com.br>
To: linux-kernel@vger.kernel.org
Subject: page_alloc.c:121! error more information
Date: Fri, 7 Feb 2003 17:04:47 -0300
Message-Id: <20030207200447.M93268@beta.bandnet.com.br>
X-Mailer: Open WebMail 1.81 20021127
X-OriginatingIP: 200.167.224.227 (breno_silva)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some changes in page_alloc.c

crit_free(struct page *page,unsigned int order)
{
 zone_t *zone;
 unsigned long free,low;
 
 zone = page_zone(page);
 free = zone->free_pages;
 low = zone->pages_low;

 if((free = low)) 
 __free_pages(page,order)
 
 return page;
}

I called this in onde part of page_alloc.c and during boot i received that 
error.

What can be wrong ?
Thanks
Breno

----------------------
WebMail Bandnet.com.br

