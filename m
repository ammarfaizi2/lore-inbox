Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266593AbUBLVCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUBLVAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:00:45 -0500
Received: from ss1000-dmz.ms.mff.cuni.cz ([195.113.20.8]:44206 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266593AbUBLU5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:57:12 -0500
Date: Thu, 12 Feb 2004 21:57:08 +0100
From: Rudo Thomas <rudo@matfyz.cz>
To: linux-kernel@vger.kernel.org
Subject: bug, or is it? - SCHED_RR and FPU related
Message-ID: <20040212205708.GA1679@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have stumbled upon a grave bug, I think. I can reproduce a hard lock-up using
xmms and a buggy plugin - only SysRq-B helps. I managed to narrow it down to
"0.5/NAN"-like operation. It only causes a complete hang when xmms is run with
SCHED_RR priority. Otherwise, only xmms hangs. Unfortunately, I was not able to
create a working proof-of-concept program.

The question is - is this a kernel bug, OR something that cannot be prevented
from happening when using SCHED_RR policy?

Tried with 2.6.3-rc[12] and glibc-2.3.2 (-r9 gentoo) with nptl support (if that
matters).

Have a nice day.

Rudo.
