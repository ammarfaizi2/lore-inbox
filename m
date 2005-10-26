Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVJZQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVJZQHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVJZQHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:07:20 -0400
Received: from mail.capitalgenomix.com ([143.247.20.203]:24759 "EHLO
	mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S964797AbVJZQHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:07:19 -0400
Message-ID: <435FA8EF.9050202@capitalgenomix.com>
Date: Wed, 26 Oct 2005 12:03:59 -0400
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: What Uses lxdialog?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Besides "make menuconfig", is there anything else in the kernel that's 
using lxdialog?

I ask because I have always wanted to add an "Abort" button for when you 
exit menuconfig that gives users the choice of returning to the root 
menu, rather than exiting (e.g. You're exiting by mistake).  I started 
working on a modification this morning and realized that menuconfig 
relies on lxdialog (particularly scripts/lxdialog/yesno.c) for 
displaying the dialog with the "Yes" and "No" buttons on it.

I almost completed a modification that will display the "Abort" button 
*only* if called with the correct parameter (in other words, it defaults 
to only the "Yes" and "No" buttons).  However, I'd like to test that I 
haven't broken anything else that might be relying on lxdialog.  In 
particular, I'm concerned with anything using the "yesno" functionality 
of lxdialog that I may have overlooked.

Thank you,

-- 
Sean

