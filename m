Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbVINR1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbVINR1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbVINR1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:27:15 -0400
Received: from smtpout.mac.com ([17.250.248.45]:48086 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965249AbVINR1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:27:14 -0400
In-Reply-To: <20050914132045.GS28551@csclub.uwaterloo.ca>
References: <4325F3D5.9040109@spamtest.viacore.net> <20050912.144107.37064900.davem@davemloft.net> <4325FADB.4090804@spamtest.viacore.net> <20050912.151230.100651236.davem@davemloft.net> <43260A8D.1090508@spamtest.viacore.net> <20050913165228.GG28578@csclub.uwaterloo.ca> <432705A0.1070407@spamtest.viacore.net> <5A770DA0-A30F-45B1-A47A-2FD21714FA3C@mac.com> <20050914132045.GS28551@csclub.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7B6BBC6F-EB09-4B88-A8C8-C9DFB7348711@mac.com>
Cc: Joe Bob Spamtest <joebob@spamtest.viacore.net>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Pure 64 bootloaders
Date: Wed, 14 Sep 2005 13:26:54 -0400
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2005, at 09:20:45, Lennart Sorensen wrote:
> On Tue, Sep 13, 2005 at 11:44:55PM -0400, Kyle Moffett wrote:
>
>> PowerPC was designed 64-bit from the start too!  It's just that the
>> architecture design group also realized that there would be a demand
>> for 32-bit CPUs, and so from the _64-bit_ system, they designed a 32-
>> bit system whose entire instruction set would be forward-compatible
>> to 64-bit systems when they came out.  That's why 32-bit PowerPC
>> machine code and 64-bit PowerPC machine code are completely identical
>> except that 64-bit CPUs also have a few opcodes to process 64-bit
>> data and a few extra kernel-mode registers.
>
> Hmm, so how does that fit with needing both 32 and 64bit libraries  
> on a
> ppc system?  It seems apple forgot the 64bit part of a library  
> recently
> in a security fix, or is that something more to do with their os than
> the cpu?

Well, if you want to pass 64-bit pointer values to a library, the  
library needs to have functions that take 64-bit values and use 64- 
bit operations on them, just like all the other archs :-D.  It also  
needs 32-bit compatibility functions for the old 32-bit-only  
programs.  On the other
hand, if you don't care about compatibility with 32-bit-pointer  
programs, you can omit functions that deal with 32-bit pointers and  
require everything to use 64-bit pointers.  You still need stuff like  
atoi that uses 32-bit values, though, and 64-bit-only does have a  
performance penalty.

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


