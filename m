Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbQKCMzT>; Fri, 3 Nov 2000 07:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129026AbQKCMzJ>; Fri, 3 Nov 2000 07:55:09 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:33500 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129049AbQKCMy4>; Fri, 3 Nov 2000 07:54:56 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jonathan George <Jonathan.George@trcinc.com>,
        "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <Pine.LNX.4.21.0011011402010.11112-100000@duckman.distro.conectiva>
Organisation: SAP LinuxLab
Date: 03 Nov 2000 13:54:28 +0100
Message-ID: <qwwy9z16wsb.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Wed, 1 Nov 2000, Rik van Riel wrote:
> The 2.4 VM is basically pretty good when you're not
> thrashing and has efficient management of the VM until
> your working set reaches the size of physical memory.
> 
> But once you hit the thrashing point, the VM falls
> flat on its face. This is a nasty surprise to many
> people and I am working on (trivial) thrashing control,
> but it's not there yet (and not all that important).

I looked into this argument a little bit further: 
In my usual stress tests 12 processes select a random memory object
out of 15 to mmap() or shmat() it and then access it serially. Each
segment is 666000000 bytes and I have 8GB of memory. So at one time
there are at most 666000000*12 bytes = 7.45GB memory attached and in
use. So I do not see that the machine qualifies as thrashing. Of
course the memory pressure is very high all the time since we have to
swap out unused segments.

But the current VM does not behave good at all on that load.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
