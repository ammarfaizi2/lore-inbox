Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTI2W3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbTI2W3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:29:38 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:24008 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263017AbTI2W3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:29:37 -0400
Date: Mon, 29 Sep 2003 18:29:32 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200309292229.h8TMTWw32486@devserv.devel.redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Many groups patch.
In-Reply-To: <mailman.1064857032.26219.linux-kernel2news@redhat.com>
References: <mailman.1064857032.26219.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This version drops the internal groups array (it's so often shared
>> that it's not worth it, and the logic becomes a bit neater), and does
>> vmalloc fallback in case someone has massive number of groups.
> 
> Why?

> The vmalloc space is limited, and the code just gets uglier.

Tim was going to write a version that segments groups into
smaller arrays. I reckon it was too difficult?

> Have you been looking at glibc sources lately, or why do you believe that 
> we should encourage insane usage?

We have some customers who run insane number of groups,
with their own patches. This practice is popular in the
Beowulf crowd for some reason. I should note this is not
very mainstream.

-- Pete
