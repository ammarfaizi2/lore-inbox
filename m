Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVBVU4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVBVU4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 15:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVBVU4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 15:56:55 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:31941 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261243AbVBVU4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 15:56:48 -0500
Message-ID: <421B9C86.8090800@nortel.com>
Date: Tue, 22 Feb 2005 14:56:38 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Anthony DiSante <theant@nodivisions.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu> <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no> <421B14A8.3000501@nodivisions.com> <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com> <421B9018.7020007@nodivisions.com> <200502222024.j1MKOtlZ007512@laptop11.inf.utfsm.cl>
In-Reply-To: <200502222024.j1MKOtlZ007512@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Anthony DiSante <theant@nodivisions.com> said:

>>That's one of the things I asked a few messages ago.  Some people on the 
>>list were saying that it'd be "really hard" and would "require a lot of 
>>bookkeeping" to "fix" permanently-D-stated processes... which is completely 
>>different than "impossible."
> 
> Most people here have little clue. It can't be done.

I realize it would be extremely difficult if not impossible to do in the 
current linux architecture, but I find it hard to believe that it is 
technically impossible if one were allowed to design the system from 
scratch.

Maybe I'm on crack, but would it not be technically possible to have all 
resource usage be tracked so that when a task tries to do something and 
hangs, eventually it gets cleaned up?

We already handle cleaning up stuff for userspace (memory, file 
descriptors, sockets, etc.).  Why not enforce a design that says "all 
entities taking a lock must specify a maximum hold time".  After that 
time expires, they are assumed to be hung, and all their resources 
(which were being tracked by some system) get cleaned up.

It would probably be complicated, slow, and generally not worth the 
effort.  But it seems at least technically possible.

Chris
