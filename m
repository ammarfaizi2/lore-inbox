Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbVJ0Xw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbVJ0Xw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbVJ0Xw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:52:27 -0400
Received: from junki.org ([194.154.83.175]:44806 "EHLO junki.org")
	by vger.kernel.org with ESMTP id S932687AbVJ0Xw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:52:27 -0400
Subject: Lock page with HIGHMEM
From: Mishael A Sibiryakov <death@junki.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 28 Oct 2005 03:52:23 +0400
Message-Id: <1130457144.23846.40.camel@me.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

I have "little" troubles with HIGHMEM.

The situation:
I have a some pages which allocated via kmalloc(), after this pages is
locked by get_page(). This pages is used in interrupt context, also in
#PF too. When this code working on kernel without HIGHMEM support, then
everything is fine. But when kernel with HIGHMEM then pages will be
unmapped from linear space (i think) and i have a triple exception and
you know that happens further :)
I've try lock pages via get_user_pages, w/wo vma, by set
SetPageReserved , Locked and etc. But nothing.

How i can avoid this problem ? E.g. how i can lock page in kernel and be
assured about that that it will not be unmapped, and can be accessed via
linear address every time ?


