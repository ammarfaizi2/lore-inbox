Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263867AbTCUTyK>; Fri, 21 Mar 2003 14:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263865AbTCUTdu>; Fri, 21 Mar 2003 14:33:50 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:45803 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S263864AbTCUTd0>; Fri, 21 Mar 2003 14:33:26 -0500
Date: Fri, 21 Mar 2003 11:44:17 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
Message-ID: <20030321194417.GC31586@ca-server1.us.oracle.com>
References: <3E7A59CD.8040700@mvista.com> <20030321131744.GL27366@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321131744.GL27366@admingilde.org>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 02:17:44PM +0100, Martin Waitz wrote:
> why don't you simply use asm("rdtsc") ?
> (ok, you should make sure that you always ask the same processor and
> stuff, but using the built in TSC seems to do everything you want...)

	It does.  That's the point.  monotonic_clock() is intended as a
portable and consistent wrapper around such access.  Otherwise, any
module that needs such access must do system specific work (TSC on x86,
cyclone on x86-x440, other stuff on S/390, etc).  In addition, having
speedstep handling in one place is a good thing.

Joel

-- 

Life's Little Instruction Book #335

	"Every so often, push your luck."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
