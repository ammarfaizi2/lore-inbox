Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSEUUbr>; Tue, 21 May 2002 16:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSEUUbq>; Tue, 21 May 2002 16:31:46 -0400
Received: from holomorphy.com ([66.224.33.161]:42126 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316588AbSEUUbq>;
	Tue, 21 May 2002 16:31:46 -0400
Date: Tue, 21 May 2002 13:31:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erik McKee <camhanaich99@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG 2.4.19-pre8-ac1 + preempt
Message-ID: <20020521203120.GJ2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erik McKee <camhanaich99@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020521195317.GH2046@holomorphy.com> <20020521202351.42147.qmail@web14202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 01:23:51PM -0700, Erik McKee wrote:
> It's preempt-kernel-rml-2.4.19-pre8-ac1-1.patch from
> http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/linux-2.4/preempt-kernel-rml-2.4.19-pre8-ac1-1.patch
> It applied cleanly with no mods needed and had been running fine untill this
> decided to happen.  Seems like slocate's updatedb decided to jack the load up
> which triggered oom?  However, the chosen process was unkillable since its the
> same process listed in the oom report over and over again?

This looks to me like the IDE driver faulted in the interrupt handler,
everything after that is probably no more than just the usual system
state corruption from such events.


Cheers,
Bill
