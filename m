Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVDMMAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVDMMAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 08:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDMMAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 08:00:09 -0400
Received: from hacksaw.org ([66.92.70.107]:19670 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S261312AbVDMMAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 08:00:04 -0400
Message-Id: <200504131159.j3DBxsoa010918@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Tomko <tomko@haha.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before 
 using it
In-reply-to: Your message of "Wed, 13 Apr 2005 21:33:27 +1000."
             <1113392007.5516.26.camel@gaston> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Apr 2005 07:59:54 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Why not use it directly
>Some of these reasons are:

It seems like you gave reason why userland pointers shouldn't be trusted, not 
why userland data should be copied into kernel land. All the problems you 
mentioned would have to be solved by the kernel regardless of copying the data 
around.

Ummm... Except for the who's mapped now problem. That's pretty weird. I guess 
that's something that comes with trying to use tons of RAM in a 32 bit system.

I thought the big issue was the need to lock the page(s) during the call, and 
maybe some tricky races which made the idea difficult.
-- 
The key is realizing the whole world is stupid and being happy anyway
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


