Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267603AbSLSKhb>; Thu, 19 Dec 2002 05:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbSLSKh0>; Thu, 19 Dec 2002 05:37:26 -0500
Received: from comtv.ru ([217.10.32.4]:58568 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S267603AbSLSKgr>;
	Thu, 19 Dec 2002 05:36:47 -0500
X-Comment-To: William Lee Irwin III
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       David Lang <david.lang@digitalinsight.com>, Robert Love <rml@tech9.net>,
       Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 15000+ processes -- poor performance ?!
References: <1040262178.855.106.camel@phantasy>
	<Pine.LNX.4.44.0212181743350.7848-100000@dlang.diginsite.com>
	<20021219020552.GO31800@holomorphy.com>
	<200212191015.gBJAFss28329@Port.imtp.ilyichevsk.odessa.ua>
	<20021219102720.GT31800@holomorphy.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 19 Dec 2002 13:37:30 +0300
In-Reply-To: <20021219102720.GT31800@holomorphy.com>
Message-ID: <m3u1hapa51.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> William Lee Irwin (WLI) writes:

 WLI> On 19 December 2002 00:05, William Lee Irwin III wrote:
 >>> Well, a better solution would be a userspace free of /proc/
 >>> dependency.  Or actually fixing the kernel. proc_pid_readdir()
 >>> wants an efficiently indexable linear list, e.g. TAOCP's 6.2.3
 >>> "Linear List Representation". At that point its expense is
 >>> proportional to the buffer size and "seeking" about the list as
 >>> it is wont to do is O(lg(processes)).

 WLI> On Thu, Dec 19, 2002 at 01:05:03PM -0200, Denis Vlasenko wrote:
 >> A short-time solution: run top d 30 to make it refresh only every
 >> 30 seconds.  This will greatly reduce top's own load skew.

 WLI> As userspace solutions go your suggestions is just as good. The
 WLI> kernel still needs to get its act together and with some
 WLI> urgency.

what about retreiving info from /proc/kmem or something like? just to 
avoid binary -> text(proc) -> binary



