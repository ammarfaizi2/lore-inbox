Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUJSLkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUJSLkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUJSLiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 07:38:15 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:47266 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268316AbUJSLNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 07:13:39 -0400
Message-ID: <4174F6DB.3000304@kolivas.org>
Date: Tue, 19 Oct 2004 21:13:31 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>
Subject: 2.6.9-ck1
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are patches designed to improve system responsiveness with 
specific emphasis on the desktop, but configurable to any workload.

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck1/patch-2.6.9-ck1.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches and a server specific patch available.


Added:
  +block_fix.diff
A small fix for congestion which was causing stalls under heavy i/o load.

  +269rc4-mingo_ll.diff
  +269rc4-mingo-bkl.diff
The low latency hacks in current -mm releases by Ingo Molnar, including 
the preemptible big kernel lock

  +ll-config.diff
Default the preemptible kernel lock off

  +nvidia_compat.diff
This allows the current version of the evil binary nvidia drivers to 
compile.

  +buildfix.diff
This is a last minute fix for 2.6.9 that causes internal compiler errors

  +269ck1-version.diff
Version


Changed:
  ~2.6.9_to_staircase9.0.diff
Latest version of staircase cpu scheduler. This is version8.K renamed in 
line with kernel release. There are no known bugs with this release. The 
main changes since last -ck released staircase are significantly better 
handling of subjiffy timeslices, and much larger timeslices for -niced 
processes as per mainline.

  ~schedbatch2.5.diff
  ~schediso2.8.diff
Resync with latest staircase.

  ~mwII.diff
The mapped watermark code was incompatible with newer vm changes so it 
was rewritten and is much less likely to cause oom. The same sysctls 
still exist (vm.mapped and vm.hardmaplimit), but the hardmaplimit is off 
by default. If you still have large amounts of swapping under heavy disk 
i/o I recommend turning this on.

  ~cfq2-20041019.patch
One small bugfix.


Full patchlist:
2.6.9_to_staircase9.0.diff
schedrange.diff
schedbatch2.5.diff
schediso2.8.diff
mwII.diff
1g_lowmem1_i386.diff
cfq2-20041019.patch
block_fix.diff
defaultcfq.diff
269rc4-mingo_ll.diff
269rc4-mingo-bkl.diff
ll-config.diff
cddvd-cmdfilter-drop.patch
nvidia_compat.diff
buildfix.diff
269ck1-version.diff


Cheers,
Con Kolivas

