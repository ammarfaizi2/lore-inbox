Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288184AbSACEBv>; Wed, 2 Jan 2002 23:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288186AbSACEBc>; Wed, 2 Jan 2002 23:01:32 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:24837 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S288184AbSACEBU>; Wed, 2 Jan 2002 23:01:20 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Art Hays" <art@lsr.nei.nih.gov>, <linux-kernel@vger.kernel.org>
Subject: RE: kswapd etc hogging machine
Date: Wed, 2 Jan 2002 20:01:29 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBAECPEFAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0201022214230.8413-100000@lsr-linux>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well known, yes -- simple solution, not yet :)). This problem has been
kicking around in one form or another for *months*, and although partial
solutions have made their way into more recent kernels, someone reports
issues of this nature on a more or less daily basis. What is happening is
that Linux sees nothing better to do with free memory, so it fills it up
with data from I/O into the page cache. Then when something comes along that
wants memory, the system goes into conniption fits trying to reclaim the
memory from the page cache and give it to the process that wants it.

There were a whole bunch of tuning parameters in the VM in 2.2 that got
dropped in 2.4; maybe re-instating some of them and returning them to their
rightful owner, the system administrator, would solve this problem once and
for all. But for some reason, those who control Linux have decided that this
is "a bug in the VM" and pursued fixes in code and the associated logic
rather than give us sysadmins what I believe is rightfully ours. I request
such tuning parameters at least once a week here, and get ignored. I'll keep
asking until I know enough about the code to put them in myself, assuming no
one has broken down and admitted that someone who's been performance tuning
operating systems since 1974 just might know what he's talking about :)).

Anyone else want to share my soapbox??? :))
--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

