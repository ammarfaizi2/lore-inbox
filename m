Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbSLFEDs>; Thu, 5 Dec 2002 23:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbSLFEDs>; Thu, 5 Dec 2002 23:03:48 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:31657 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267544AbSLFEDr> convert rfc822-to-8bit; Thu, 5 Dec 2002 23:03:47 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Matt Young <wz6b@arrl.net>
Reply-To: wz6b@arrl.net
To: linux-kernel@vger.kernel.org
Subject: Help me to hack on the task_struct
Date: Thu, 5 Dec 2002 20:10:53 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212052010.53696.wz6b@arrl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When hacking with my module code: 

I do not get reasonable results when using the "current"  macro to access 
parts of the task structure.

Things seem to diverge past a thing called rlim in the task_struct..
There are supposedly RLIM_NLIMITS of these rlims.

So I looked through that wonderful cross reference at sourceforge
to discover these defined in resource.h:

#define RLIMIT_CPU      0               /* CPU time in ms */
#define RLIMIT_FSIZE    1               /* Maximum filesize */
#define RLIMIT_DATA     2               /* max data size */
#define RLIMIT_STACK    3               /* max stack size */
#define RLIMIT_CORE     4               /* max core file size */
#define RLIMIT_RSS      5               /* max resident set size */
#define RLIMIT_NPROC    6               /* max number of processes */
#define RLIMIT_NOFILE   7               /* max number of open files */
#define RLIMIT_MEMLOCK  8               /* max locked-in-memory address space 
*/
#define RLIMIT_AS       9               /* address space limit */
#define RLIMIT_LOCKS    10              /* maximum file locks held */
#define RLIM_NLIMITS    11

Questions:
Why do resource limits happen to count sequencially?

And can I expect the task structure in sched.h to conform to the compiled
kernel?

With my SUSE 8.1 linux. I am using 2.4.19 in my headers and 2.4.19GB in the
runnitg kernel. (Insmod bitches a little)

Any clues are appreciated.

