Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUDJHme (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 03:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUDJHme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 03:42:34 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28619 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261791AbUDJHmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 03:42:32 -0400
Message-ID: <4077A542.8030108@nortelnetworks.com>
Date: Sat, 10 Apr 2004 03:41:54 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: want to clarify powerpc assembly conventions in head.S and entry.S
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm doing some work in head.S and entry.S, and I just wanted to make 
sure that I had the conventions down.

According to the docs I read, r0 and r3-12 are caller-saves.  They seem 
to be saved in EXCEPTION_PROLOG_2 (head.S) and restored in 
ret_from_except() (entry.S).  Thus, if I add code in entry.S I should be 
able to use any of those registers, without having to worry about 
restoring them myself--correct?

Also, I'm a bit confused about the three instances of the following line 
in entry.S:

	stwcx.	r0,0,r1			/* to clear the reservation */

I don't see the corresponding lwarx instruction.  What reservation is it 
referring to?

Thanks,

Chris
