Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbTCJF01>; Mon, 10 Mar 2003 00:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262729AbTCJF01>; Mon, 10 Mar 2003 00:26:27 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:41734
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262728AbTCJF00>; Mon, 10 Mar 2003 00:26:26 -0500
Subject: Re: [RFT] port of Lockmeter on i386 2.5.64 Patch
From: Robert Love <rml@tech9.net>
To: Valdis.Kletnieks@vt.edu
Cc: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200303100533.h2A5XoWS003419@turing-police.cc.vt.edu>
References: <149620000.1047264510@w-hlinder>
	 <200303100533.h2A5XoWS003419@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1047274616.7865.11.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 10 Mar 2003 00:36:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 00:33, Valdis.Kletnieks@vt.edu wrote:

> > +config LOCKMETER
> > +	bool "Kernel lock metering"
> > +	depends on SMP
> 
> Should that be 'depends on SMP || PREEMPT'?  I remember the original 2.4
> pre-empt patches had one to deal with instrumenting/breaking locks. Not sure
> if that logic still applies...

No, it depends on SMP alone.

To do the metering, it needs the actual locks compiled into the kernel.

I believe what you are thinking of is the preempt-stats patch, which
measures periods of non-preemptibility.  Same idea but different.

	Robert Love

