Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbRDJUOY>; Tue, 10 Apr 2001 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRDJUOO>; Tue, 10 Apr 2001 16:14:14 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:340 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132053AbRDJUOF>; Tue, 10 Apr 2001 16:14:05 -0400
Message-ID: <3AD36912.1F9E0654@sgi.com>
Date: Tue, 10 Apr 2001 13:12:02 -0700
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de, torvalds@transmeta.com
Subject: BH_Req question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems BH_Req is set on a buffer_head by submit_bh.
What part of the code unsets this flag during normal
operations? One path seems to be block_flushpage->unmap_buffer
->clear_bit(BH_Req), but IIRC block_flushpage is used only
for truncates. There must be another path to unset BH_Req
under normal memory pressure, or (more unambiguously) on IO completion.

So: in what ways can BH_Req be unset?

Thanks for any input, i've been staring at the code for long without avail ...

cheers,

ananth.

PS: In case why the question: I've got a system with tons of
pages with buffers marked BH_Req, so try_to_free_buffers() bails
out thinking that the buffer is busy ...

-- 
--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
