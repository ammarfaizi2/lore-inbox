Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVJHXfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVJHXfB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 19:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVJHXfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 19:35:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751160AbVJHXfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 19:35:00 -0400
Date: Sat, 8 Oct 2005 16:34:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] gfp flags annotations
In-Reply-To: <20051006201534.GX7992@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
References: <20050905155522.GA8057@mipter.zuzino.mipt.ru>
 <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk>
 <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk>
 <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk>
 <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk>
 <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Al Viro wrote:
> 
> a) typedef unsigned int __nocast gfp_t;

Btw, since you did a typedef, any reason why it isn't marked __bitwise 
too? It would seem that all valid uses of it are bit tests with predefined 
values, ie a __bitwise restriction would seem very natural, no?

		Linus
