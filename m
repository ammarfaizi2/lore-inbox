Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSJMLCB>; Sun, 13 Oct 2002 07:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSJMLCB>; Sun, 13 Oct 2002 07:02:01 -0400
Received: from smtp01.iprimus.net.au ([210.50.30.70]:28682 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S261492AbSJMLCB>; Sun, 13 Oct 2002 07:02:01 -0400
Message-ID: <3DA9542E.6010407@users.sourceforge.net>
Date: Sun, 13 Oct 2002 21:08:30 +1000
From: James Courtier-Dutton <jcdutton@users.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel api for application profiling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2002 11:07:49.0258 (UTC) FILETIME=[C442CEA0:01C272A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am helping to write a multi-media application that plays lots of 
different video and audio formats.
I would like to improve the performance of the program.
I wish to be able to make a function call to start a timer, and then 
later on in the program stop the timer and therefore gather information 
about how long a particular routine took.
The problem I have is that between start of timer and stop of timer, the 
kernel might task switch to another thread or process. I would like this 
kernel task switch to automatically stop the timer, and then restart it 
when I get CPU time returned. I cannot find any such API availiable 
currently in the linux kernel.

Also, as an extension to this, it would be nice to know which other 
tasks happened during the task switch. The reason I would like this, is 
so that I can tell if the time was taken reading data off the hard disk 
or instead time spent by X displaying/transfering to screen the next 
video frame. If too much time is being spent doing a task like reading 
from the hard disk, I would need to look into reducing the latency of 
that task. This might also highlight buggy modules that take up too much 
of a time slice. I have seen some task switches take 800ms away from my 
audio out thread, and therefore causing underruns on the sound hardware, 
that then causes glitches in the perceived audio coming from the speakers.

Also, the reason for the above requests is so that I can gather useful 
performance info without having to trawl through hugh global performance 
traces.

Can anyone help me?

Cheers
James



