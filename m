Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWJLS3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWJLS3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWJLS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:29:23 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:12461 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1750794AbWJLS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:29:22 -0400
Message-ID: <452E8980.5040504@comcast.net>
Date: Thu, 12 Oct 2006 14:29:20 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <452E876F.1000604@cfl.rr.com>
In-Reply-To: <452E876F.1000604@cfl.rr.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Phillip Susi wrote:
> John Richard Moser wrote:
>> Can context switches be made faster?  This is a simple question, mainly
>> because I don't really understand what happens during a context switch
>> that the kernel has control over (besides storing registers).
>>
> 
> Besides saving the registers, the expensive operation in a context
> switch involves flushing caches and switching page tables.  This can be
> avoided if the new and old processes both share the same address space.
> 

i.e. this can be avoided when switching to threads in the same process.

How does a page table switch work?  As I understand there are PTE chains
which are pretty much linked lists the MMU follows; I can't imagine this
being a harder problem than replacing the head.  I'd imagine the head
PTE would be something like a no-access page that's not really mapped to
anything so exchanging it is pretty much exchanging its "next" pointer?


> 
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRS6JfQs1xW0HCTEFAQL9NQ//Qs7SGrlE0fGDj0HFssed/cVDrjR9GUFL
RzjJFNyB0DmDKLEcIfcYjWnvvyvFX1ggCPYflOcUXo57jz6GCsSBs0p+nXAheZiH
B301nk4ZKj6B18UOqv3NDY7r5wV0L2x54TM98Ty4CxgvKw5Jglno4fLZQs9Tefmk
2woLmyJkiDG2xlRijmfEbSXQPo/wNIfYaDrJlvRPgEJiDa1j7cCHP+o2wZEnJCr9
UMpEooaZ8n8cO5CVP7YiG/sG52GG3cbW9j5FbueQOAjxySNX2X8JVT3wLGHixvB4
z6BpvnCpgNVoe1LQFDleUjP3Lb0rO9ap3HMlLJ/lbs7LeegLgtUDW2uaa4PXcc9C
uEiwA1BNEZMIYhSsiek+acojmmGh9zOsI2nfjBmZoj6UJOjSyYz7srZTWKLILVi+
0hffeQs2FWHQ7sMSRhjM8ITMjZGvK85AnBwdsf2jEIGGOMixq2BAkYu+Ljq5FLOJ
VKdaqmLq60vzMqLeb7pdWJgDXNvxU5RLvnktkuPBSlftPLwNvGf1GVSEXEKkJ9/Y
VhTfX9gFKHC59N9qn01KpkhG9cVXfUPU5nDlfYdCrgkf7QX4aTEg6kt9ALg4fDlN
W2cFr4bfjGLBmqsI9FP/Zxq42N1F9bXIym3HcSmTn/fsoiTQdUcuxUKkdKA7cXiE
xMyKfw/+y0Q=
=NEcB
-----END PGP SIGNATURE-----
