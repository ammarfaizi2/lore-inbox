Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268111AbTCFOBN>; Thu, 6 Mar 2003 09:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268112AbTCFOBN>; Thu, 6 Mar 2003 09:01:13 -0500
Received: from pushme.nist.gov ([129.6.16.92]:45978 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id <S268111AbTCFOBL>;
	Thu, 6 Mar 2003 09:01:11 -0500
To: linux-kernel@vger.kernel.org
Subject: TransMeta longrun control utility maintainer?
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Thu, 06 Mar 2003 09:11:18 -0500
Message-ID: <9cfy93s4mbd.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know this isn't the best place to ask, but maybe someone here knows.

Who is maintaining the longrun(1) (should probably be longrun(8))
utility?  The author is listed as Daniel Quinlan
<quinlan@transmeta.com>, but mail to that address bounces.

The longrun utility frobs the MSR on TransMeta processors to switch
between performance and economy modes.

On my laptop, currently running 2.4.21-pre5-ac1, I get the following
error:

# longrun -p
longrun: error reading /dev/cpu/0/cpuid: Invalid argument

# ls -l /dev/cpu/0
total 0
cr--r--r--    1 root     root     203,   0 Aug 30  2002 cpuid
crw-------    1 root     root      10, 184 Aug 30  2002 microcode
crw-------    1 root     root     202,   0 Aug 30  2002 msr

I've seen this the last couple 2.4.2x-pre versions, but I don't know
exactly when it stopped working.  I assume somewhere along the line
the CPUID interface got reformatted.  I'm pretty sure this kernel is
configured correctly:


# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_X86_LONGRUN=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

Help?
Ian

