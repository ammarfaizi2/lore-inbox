Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTD2Sgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTD2Sgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:36:50 -0400
Received: from watch.techsource.com ([209.208.48.130]:22983 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S262126AbTD2Sgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:36:49 -0400
Message-ID: <3EAEC964.5040007@techsource.com>
Date: Tue, 29 Apr 2003 14:50:12 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Mark Grosberg <mark@nolab.conman.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
References: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org> <Pine.LNX.4.53.0304280855240.16444@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

>  
>
>To save some processing time, most knowledgeable software
>engineers would use vfork(). This leaves the major time,
>the time necessary to load the new application into the
>new address space and begin its execution. This time could
>be tens of milliseconds or even hundreds if the application
>is on a CD, floppy, a disk that hasn't been accessed yet,
>or the network. In the usuall situation where processing
>must be performed between the fork() and the execve(), you
>can't use vfork().
>
>You can measure the time for a system call by executing
>getpid() or something similar. It is in the noise compared
>to the time necessary to execute a program. Further, we
>get to the situation where one can't even verify a supposed
>speed increase because the system call overhead is in the
>noise. Great, one can claim any improvement they want and
>it can't be verified. What will be verified, though, is
>the increase in size of the kernel.
>
>
>  
>

So, you can't save any time _for_that_particular_process_ by speeding up 
the fork.  Granted.  But that wasted CPU time could be better spent 
working on some unrelated process that is not waiting on I/O.


