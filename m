Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTDRTmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 15:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTDRTmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 15:42:20 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:44175 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S263227AbTDRTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 15:42:19 -0400
Message-ID: <313680C9A886D511A06000204840E1CF40B8A1@whq-msgusr-02.pit.comms.marconi.com>
From: "Punj, Arun" <Arun.Punj@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Punj, Arun" <Arun.Punj@marconi.com>
Subject: May be off topic : System CPU usage 
Date: Fri, 18 Apr 2003 15:54:10 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please cc: Arun.Punj@marconi.com ]

Folks

I am running into a curious problem on linux 2.4.20 kernel. 

The problem :

  Every 25 minutes the sytem usage as indicated by "top -i -d 1" 
  goes up from 0 to about 50% and stays at this level for around 
  100 seconds and than comes down to zero or near zero again. 
  The user cpu % stays at 0. And the CPU used by all the active 
  process put togather stays below 5%

  The system is idle when this happens in so far as I can tell. 
  The only tasks which show up in the top are :
    -- "X" and [ CPU usage ~ 5%]
    -- top itself [ CPU usage ~ 0%]

  The hardware configuration is as follows:
    P4 2.4Ghz 512M Ram, 128M IDE compatible Flash Drive, 
    there is a 50 Meg CramFs parition on flash and 200 M
    ext3 partition.


Could this be a kernel configuration issue.

Any help would be greatly appreciate.

thanks
Arun Punj

A snippet of what top looks like when this happens, observe the system
usage:
----------------------------------------------------------------------------


  8:59am  up 1 day, 22:21,  5 users,  load average: 0.56, 0.49, 0.46
79 processes: 74 sleeping, 4 running, 0 zombie, 1 stopped
CPU states: 1.7% user,  48.9% system,  0.0% nice, 49.4% idle
Mem:   506380K av,  217256K used,  289124K free,       0K shrd,   15976K
buff
Swap:       0K av,       0K used,       0K free                   88928K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  712 root      17  -1  142M  13M  2620 R <   4.9  2.7 209:28 X
 7917 root       9   0  1100 1100   876 R     0.0  0.2   0:00 top
 
-------------------------------------------------------------------------
  
