Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287896AbSAPVe7>; Wed, 16 Jan 2002 16:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287940AbSAPVep>; Wed, 16 Jan 2002 16:34:45 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:24231 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S287932AbSAPVeE>;
	Wed, 16 Jan 2002 16:34:04 -0500
Message-ID: <3C45F1C6.2010409@student.uni-kl.de>
Date: Wed, 16 Jan 2002 22:33:58 +0100
From: "R. Sinoradzki" <sinoradz@student.uni-kl.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011126
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Carlson <justincarlson@cmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: multithreading  on a multiprocessor system ( a bit OT )
In-Reply-To: <3C45D95C.7000402@student.uni-kl.de> <1011212204.314.3.camel@gs256.sp.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Carlson wrote:

> On Wed, 2002-01-16 at 14:49, R. Sinoradzki wrote:
> 
>>O.K my question:
>>Consider two modern processors that share some data and a lock.
>>The lock may be implemented with something like an atomic test-and-set
>>instruction. Now processor 'A' acquires the lock and works with the data.
>>Processor 'B' also wants to access the data, but internally reorders it's
>>instructions because the instructions seem independent from each other.
>>So 'B' might access the data without having the lock.
>>If it's a single processor system, reordering instructions in a way that
>>ensures that it looks 'as if' everything has been executed in the right order
>>might be easy, but in a multiprocessor system 'A' doesn't know 'B's state.
>>
> 
> Then you've got a bug.  Modern implementations that do SMP provide some
> way of placing barriers around speculative execution structures to make
> sure you don't, say, go out and read some memory location that changes
> state in a device because that's an OK speculative action to take.
> 
> Can't really comment on x86, as I'm not very good with it, but taking
> for example MIPS and Alpha, in addition to the ll-sc ops, there are a
> sync and mb instructions, respectively, which provide a method for
> assuring that previous operations have become visible in terms of
> general machine state before going on.
> 
> -Justin
> 

Ah, thank you for the keywords.
Sorry, I should have searched "multiprocessor synchronization" in Google, but
I tried something else that gave me a lot of useless results ...

Ralf

