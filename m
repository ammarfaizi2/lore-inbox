Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSAPTt4>; Wed, 16 Jan 2002 14:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSAPTtq>; Wed, 16 Jan 2002 14:49:46 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:18581 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S287368AbSAPTtn>;
	Wed, 16 Jan 2002 14:49:43 -0500
Message-ID: <3C45D95C.7000402@student.uni-kl.de>
Date: Wed, 16 Jan 2002 20:49:48 +0100
From: "R. Sinoradzki" <sinoradz@student.uni-kl.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011126
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: multithreading  on a multiprocessor system ( a bit OT )
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I ask here, because I think it's probably a good place
to get some hints, links, papers or book recommendations.
I am absolutely new to multiprocessing. I only took a basic OS course
and did some practical training with NachOS ...

O.K my question:
Consider two modern processors that share some data and a lock.
The lock may be implemented with something like an atomic test-and-set
instruction. Now processor 'A' acquires the lock and works with the data.
Processor 'B' also wants to access the data, but internally reorders it's
instructions because the instructions seem independent from each other.
So 'B' might access the data without having the lock.
If it's a single processor system, reordering instructions in a way that
ensures that it looks 'as if' everything has been executed in the right order
might be easy, but in a multiprocessor system 'A' doesn't know 'B's state.

My idea is, that there are special instructions that prevent reordering in
this case, but would this be enough and what does really happen ?

bye, Ralf

