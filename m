Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265112AbUGCNzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbUGCNzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 09:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUGCNzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 09:55:40 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:38415 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S265112AbUGCNzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 09:55:39 -0400
Message-ID: <40E6BAB4.1030202@mauve.plus.com>
Date: Sat, 03 Jul 2004 14:55:00 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Tracking down source of wrong interrupt 2.6.7.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ITE raid card, which sort-of-works with my k7s5a motherboard.
Using the GPL driver from ite.
(copy at http://www.mauve.demon.co.uk/iteraid.c)

It causes massive keyboard problems, complaining about keycode 0 being undefined.

I suspect this is due to interrupt 1 (i8042) somehow being triggered every
time that 11 (it8218) is.

About 80% of the time.
Any clues about where in general I should start looking?
