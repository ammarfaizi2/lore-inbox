Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbUL0RAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbUL0RAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUL0RAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:00:07 -0500
Received: from f32.mail.ru ([194.67.57.71]:20998 "EHLO f32.mail.ru")
	by vger.kernel.org with ESMTP id S261927AbUL0RAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:00:04 -0500
From: Samium Gromoff <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: controlling the initcall order
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 192.168.1.102 via proxy [80.92.98.198]
Date: Mon, 27 Dec 2004 20:00:01 +0300
Reply-To: Samium Gromoff <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1CiyDx-0008NU-00._deepfire-mail-ru@f32.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I`d like to make excuses in advance if this question was already 
explained somewhere, but i took some effort and found nothing 
satisfactorily clarifying. 
 
So, in this case i have a subarch-specific block device driver which 
resides in arch/$ARCH/$SUBARCH. Yes, it only makes sense on that subarch. 
 
Its init routine is module_init()`d and gets called before the io 
schedulers have a chance to get themselves registered. Boom. 
 
So how do i get my init routine called later? 
 
--- 
cheers, 
   Samium Gromoff 
