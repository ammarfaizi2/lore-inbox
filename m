Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTAURUs>; Tue, 21 Jan 2003 12:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTAURUs>; Tue, 21 Jan 2003 12:20:48 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:29130 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S267125AbTAURUq>; Tue, 21 Jan 2003 12:20:46 -0500
Date: Tue, 21 Jan 2003 09:29:41 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121172941.GT20972@ca-server1.us.oracle.com>
References: <200301210135.h0L1ZFa06867@eng2.beaverton.ibm.com> <1043113336.32478.97.camel@w-jstultz2.beaverton.ibm.com> <20030121020015.GQ20972@ca-server1.us.oracle.com> <1043117157.32472.116.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043117157.32472.116.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 06:45:57PM -0800, john stultz wrote:
> > 	I'll look into it, but it must absolutely be in terms of wall
> > clock time as measured from outside the system.
> 
> Completely understandable. do_gettimeofday will give you just that (w/o
> the conversion muck w/ HZ and loops_per_jiffy). 

	It looks as though gettimeofday calculates wall time from
jiffies.  If you udelay(), jiffies doesn't increment and you lose time
(this is exactly what I'm trying to track here).  How does gettimeofday
avoid this (maybe I'm misreading the code)?  

Joel

-- 

"Can any of you seriously say the Bill of Rights could get through
 Congress today?  It wouldn't even get out of committee."
	- F. Lee Bailey

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
