Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUKK4>; Wed, 21 Feb 2001 05:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBUKKq>; Wed, 21 Feb 2001 05:10:46 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:39180 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S129051AbRBUKKf>; Wed, 21 Feb 2001 05:10:35 -0500
Date: Wed, 21 Feb 2001 11:10:32 +0100
From: Michal Vitecek <M.Vitecek@sh.cvut.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: maximum process size on i386?
Message-ID: <20010221111032.A13319@fuf.sh.cvut.cz>
In-Reply-To: <20010220120358.A8211@fuf.sh.cvut.cz> <200102202023.f1KKNap30937@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200102202023.f1KKNap30937@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Feb 20, 2001 at 03:23:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 hello and thank you for your answers.

"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
>>    i have processes that have to be really over 1gb (database engines) but
>>  unfortnately, when one reaches over 900mb kswapd starts eating 50+% of 1
>>  cpu and the whole thing gets slower.
>
>You didn't provide output from "ps" or "top". You can not be helped.
>Maybe output from "vmstat" or "sar" would be good too.

 oh - sorry for that. here's the normal state of things (well almost, the
 processes are in the R state most of the time). however as i wrote before,
 when those processes get over ~900mb, kswapd starts paging with ~50+% cpu
 usage. i lived under the impression memory shown in SHARE column is
 'shared' so the processes summed up could actually be bigger than
 physical memory (like 6x 1.5gb SIZE, 1.49gb RSS, 1.49gb SHARE for a 4gb
 machine). am i living in the dark?

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
16578 user      14   0  705M 704M  704M D    88.9 18.6 323:57 engine
16574 user      13   0  705M 705M  704M D    87.1 18.7 388:35 engine
16568 user      12   0  705M 705M  705M D    85.8 18.7 439:38 engine
16576 user      14   0  705M 705M  705M R    83.3 18.7 364:51 engine
16575 user      16   0  704M 704M  704M R    82.4 18.6 362:39 engine
16577 user      12   0  705M 705M  705M R    78.0 18.7 332:01 engine
    3 root       9   0     0    0     0 SW   11.9  0.0 133:37 kswapd

 also, ipcs claims there's 812593152 bytes (yes, that's 774mb, when i
 configure the engines to eat more memory ipcs shows for example 1+gb of
 shared memory allocated). how can this be possible? overcommit_memory is
 set to 0.

    thank you for your help in advance,
-- 
			Michal Vitecek


------------------------------ na IRC -------------------------------------
 BillGates [bgates@www.microsoft.com] has joined #LINUX
 ...
 mode/#linux [+b BillGates!*@*] by DoDad
 BillGates was kicked off #linux by DoDad (banned: We see enough of Bill
          Gates already.)
 

