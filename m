Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271966AbRH2NvH>; Wed, 29 Aug 2001 09:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271905AbRH2Nu5>; Wed, 29 Aug 2001 09:50:57 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:25892 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S271889AbRH2Nuv>; Wed, 29 Aug 2001 09:50:51 -0400
Date: Wed, 29 Aug 2001 08:49:59 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200108291349.IAA67086@tomcat.admin.navo.hpc.mil>
To: VDA@port.imtp.ilyichevsk.odessa.ua,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Re[2]: Shutting down NFS
CC: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Hello Jesse,
> 
> Wednesday, August 29, 2001, 3:58:07 PM, you wrote:
> >> killall5 -15; sleep 5; killall5 -9; sleep 5
> >> killall5 -15; sleep 5; killall5 -9; sleep 5
> >> killall5 -15; sleep 5; killall5 -9 ?
> >> 
> >> This looks ugly and total sleep time is 25 sec.
> >> A better way is to make NFS daemons understand what user wants after
> >> first call, not a third.
> 
> JP> This already looks like overkill :-) Only the first one should be
> JP> needed. I can understand that NFSD could disable signal 15, but not
> JP> how it can disable 9... The only way I know for that to happen is
> JP> if the process is in an uninterruptable sleep for some reason (and
> JP> that should only delay signal delivery, not eliminate it).
> 
> It looks like killall5 bug - "killall -9 nfsd" kills nfsd at once.
> Do you know where killall5 source is? There's no killall5 in
> util-linux...

Glad you found it... The killall5 source is part of the sysvinit. I found
it on the Slackware 8 source disk. (I wonder about the "will not kill
processes in current session" thing... does nfsd appear to be in the
same session???? I wouldn't think so, but that would explain why some of
terminations takes so long, and why some signals appear to be disabled)

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
