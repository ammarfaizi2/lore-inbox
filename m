Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268297AbUHFUwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268297AbUHFUwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbUHFUwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:52:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:50089 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268299AbUHFUuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:50:40 -0400
Date: Fri, 06 Aug 2004 13:49:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Albert Cahalan <albert@users.sourceforge.net>,
       Roger Luethi <rl@hellgate.ch>
cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <283440000.1091825375@flay>
In-Reply-To: <1091805296.3547.2522.camel@cube>
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <20040806104630.GA17188@holomorphy.com> <20040806120123.GA23081@k3.hellgate.ch> <1091800948.1231.2454.camel@cube> <20040806170832.GA898@k3.hellgate.ch> <1091805296.3547.2522.camel@cube>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > If it's going to be this dynamic, then just give me DWARF2 debug
>> > info and the raw data. Like this:
>> > 
>> > /proc/DWARF2
>> > /proc/1000/mm_struct
>> > /proc/1000/signal_struct
>> > /proc/1000/sighand_struct
>> > /proc/1000/task/1024/thread_info
>> > /proc/1000/task/1024/task_struct
>> > /proc/1000/task/1024/fs_struct
>> 
>> That's different. The overhead would be prohibitive. Also, this exposes
>> internal kernel structures.
> 
> The overhead? I'm not seeing much, other than the multiple
> files and the very fact that field locations are movable.
> 
> As long as I can fall back to the old /proc files when truly
> radical kernel changes happen, exposure of kernel internals
> isn't a serious problem.
> 
> If I had the DWARF2 data alone, /dev/mem might be enough.
> (sadly, "top" would require some major work before I'd trust it)

We did that on PTX ... walking tasklists lockless is a bitch.

M.

