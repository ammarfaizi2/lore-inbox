Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbSIXJcb>; Tue, 24 Sep 2002 05:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbSIXJca>; Tue, 24 Sep 2002 05:32:30 -0400
Received: from pro18.it.dtu.dk ([130.225.76.218]:24452 "EHLO pro18.it.dtu.dk")
	by vger.kernel.org with ESMTP id <S261622AbSIXJc3>;
	Tue, 24 Sep 2002 05:32:29 -0400
Message-ID: <3D903262.3020003@fugmann.dhs.org>
Date: Tue, 24 Sep 2002 11:37:38 +0200
From: Anders Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Q: Scheduler and need_resched
References: <3D9026B6.3080509@fugmann.dhs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Fugmann wrote:
> Hi.
> 
> I got a small question of what happens codevice when the quantum of a 
> task is expired (counter == 0 -> need_resched == 1). Of cource schedule 
> is invoked somehow, but from where? How is the "flow". I see from where 
> do_timer is called, and that it schedules a BH, but then I'm stuck.
> 
> Any pointer appriciated.
> Anders Fugmann

Solved.
By the help of the kernel newbies pages, I was pointed to the page 
http://kernelnewbies.org/wiki/moin.cgi/Karthick, which pointed at
the label '_ret_with_reschedule' in entry.S.

This piece of assembler is called after each interrupt, and tests the 
need_resched flag to see is scheduling is nessesary.

Anyway, thanks for your time.
Anders Fugmann


