Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTD0IlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTD0IlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 04:41:11 -0400
Received: from mail6.home.nl ([213.51.128.20]:2957 "EHLO mail6-sh.home.nl")
	by vger.kernel.org with ESMTP id S263849AbTD0IlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 04:41:09 -0400
Message-ID: <3EAB99EE.30601@keyaccess.nl>
Date: Sun, 27 Apr 2003 10:50:54 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternative patching for prefetches & cleanup
References: <Pine.LNX.4.44.0304262021190.25498-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0304262021190.25498-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> That's not the fibonacci sequence, that's just a regular sigma(i)  
> (i=1..n) sequence. And if you were to generate the sequence numbers at
> compile-time I might agree with you, if you also were to avoid using 
> inline asms.

If the sigma(i) method is to stay, please note that

sigma(1 <= i <= n | i) = n*(n+1) / 2

for all n > 0 (trivial proof by induction).

That is, no need to loop; in this case, with n = num - 1

k = ((num - 1) * num) / 2

Rene.


