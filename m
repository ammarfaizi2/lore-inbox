Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130476AbRACXsE>; Wed, 3 Jan 2001 18:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACXry>; Wed, 3 Jan 2001 18:47:54 -0500
Received: from [206.112.108.255] ([206.112.108.255]:24559 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S129267AbRACXrk>; Wed, 3 Jan 2001 18:47:40 -0500
From: brian@worldcontrol.com
Date: Wed, 3 Jan 2001 15:55:40 -0800
To: linux-kernel@vger.kernel.org
Subject: soffice, 2.2.18, cpu 97% idle, loadavg 6.05
Message-ID: <20010103155540.A6026@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux 2.2.18 with VM-global patch
128MB RAM
AMD K6-3/366
Star Office 5.2

I exiting StarOffice, and a little later noticed my loadavg display
widget was showing a high load average. top reports it at 6.

Poking about, I found all the soffice.bin processes still hanging
around.

Looking with top, all the soffice.bin processes are in the 'D N' state.
In top's 'no idle' mode they are listed.

The CPU is hanging around 97% idle, the loadavg has been sitting
at 6+ for almost 15 minutes.  It seems likely this state will
continue forever.

I tried a 'kill' on all the soffice.bin process and there was
no change.  a 'kill -9' also had no effect.

What is going on?

Shouldn't I be able to tear down the processes?

Here is status on the soffice.bin process with the lowest PID:

# cat /proc/5294/status
Name:   soffice.bin
State:  D (disk sleep)
Pid:    5294
PPid:   775
Uid:    101     101     101     101
Gid:    101     101     101     101
Groups: 101 0 10 228 229 500 
VmSize:   103600 kB
VmLck:         0 kB
VmRSS:     49588 kB
VmData:    13008 kB
VmStk:      1104 kB
VmExe:        88 kB
VmLib:     73604 kB
SigPnd: 0000000000004100
SigBlk: 0000000080000000
SigIgn: 8000000000001000
SigCgt: 00000003bfc064ff
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000

Thanks,

-- 
Brian Litzinger <brian@worldcontrol.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
