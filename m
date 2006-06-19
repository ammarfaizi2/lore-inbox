Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWFSOs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWFSOs1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 10:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWFSOs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 10:48:27 -0400
Received: from ik55118.ikexpress.com ([213.246.55.118]:409 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S932503AbWFSOs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 10:48:27 -0400
Message-ID: <4496B92A.3010907@free-electrons.com>
Date: Mon, 19 Jun 2006 16:48:10 +0200
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Option to clear allocated kernel memory before freeing it?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Would it make sense to implement a kernel option that would clear kernel 
memory before freeing it (by kfree or free_page(s))?

Unless I'm missing something, uncleared memory previously used for 
kernel allocations could later be recycled for user allocations, making 
it possible for a user program to access sensitive driver data if it's 
lucky.

Tough clearing memory should be efficient (thanks to the use of 
memset(), optimized for each platform), there would of course be a 
significant performance hit. However, this could be acceptable for 
systems with strong security requirements...

What do you think? If this idea makes sense, I'll be glad to help in 
implementing it.

    Thanks in advance,

    Cheers,

    Michael.

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)

