Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVAJLvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVAJLvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVAJLvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:51:05 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26332 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262216AbVAJLvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:51:02 -0500
Date: Mon, 10 Jan 2005 12:50:53 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: keventd gives exceptional priority to usermode helpers
In-Reply-To: <20050110034202.P469@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0501101249380.4459@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0501101121370.11128@yvahk01.tjqt.qr>
 <20050110034202.P469@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -165,6 +165,7 @@ static int ____call_usermodehelper(void 
>>  
>>  	/* We can run anywhere, unlike our parent keventd(). */
>>  	set_cpus_allowed(current, CPU_MASK_ALL);
>> +        set_user_nice(current, 0);
>
>Seems reasonable.  Although, I don't see a niceval of -20, but -5 on
>keventd (workqueues do set_user_nice(-5)).  Also, this patch is

Right, `ps` only shows "<" for <0, "" for 0 and "N" for >0. But -5 is still a 
hard thing.

>whitespace damaged, should be tab not spaces.

the neverending debate...



Jan Engelhardt
-- 
ENOSPC
