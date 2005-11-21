Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVKUImz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVKUImz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVKUImz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:42:55 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:57784 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932227AbVKUImy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:42:54 -0500
Message-ID: <43818880.8080800@comhem.se>
Date: Mon, 21 Nov 2005 09:42:40 +0100
From: =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@comhem.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
References: <5aZsv-3CJ-17@gated-at.bofh.it> <E1EdwGs-0000qv-NL@be1.lrz> <438180C0.2030503@comhem.se> <200511211919.11429.kernel@kolivas.org>
In-Reply-To: <200511211919.11429.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:
> 
> Convention in the kernel would be 
> 	aztTimeOut =  HZ / 100 ? : 1;
> to be at least one tick (works for HZ even below 100) and is at least 10ms. If 
> you wanted 2 ms then use
> 	aztTimeOut =  HZ / 500 ? : 1;
> which would give you at least 2ms
> 

Thank you Con for the feedback.

Hmm.. The minimum value should be 2, right?
Otherwise the loop could time out after only a few nanoseconds.. since the loop will then timeout immediately on a clock tick.
Or am I wrong?

Best regards,
Daniel Marjamäki



