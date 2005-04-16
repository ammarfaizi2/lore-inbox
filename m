Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVDPIam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVDPIam (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 04:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDPIam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 04:30:42 -0400
Received: from hacksaw.org ([66.92.70.107]:47540 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S261411AbVDPIag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 04:30:36 -0400
Message-Id: <200504160830.j3G8UH0x031123@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: Vadim Lobanov <vlobanov@speakeasy.net>
cc: linux-os@analogic.com, "Theodore Ts'o" <tytso@mit.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Tomko <tomko@haha.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before 
 using it
In-reply-to: Your message of "Fri, 15 Apr 2005 22:18:42 PDT."
             <Pine.LNX.4.58.0504152209260.18492@shell3.speakeasy.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Apr 2005 04:30:17 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>if you want actual concrete examples, let me know.
I'd love a few, but maybe privately?


I can certainly see where always copying is simpler; I certainly consider this 
to be an optimization, which must be looked at carefully, lest you end up with 
that which speed things up a little, but adds a big maintenance headache.

But this strikes me as a potentially big speed up for movement through 
devices. (Or is there already a mechanism for that?)

>It checks if the LAST page belongs to userland, and fails if not;
I can't claim to know how memory assignment goes. I suppose that this 
statement means that the address space the userland program sees is continuous?

If not I could see a scenario where that would allow someone to get at data 
that isn't theirs, by allocating around until they got an chunk far up in 
memory, then just specified a start address way lower with the right size to 
end up on their chunk.

I'm assuming this isn't a workable scenario, right?
-- 
You are in a maze of twisty passages, all alike. Again. 
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


