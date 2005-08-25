Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVHYSIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVHYSIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVHYSIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:08:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:36273 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751369AbVHYSII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:08:08 -0400
Subject: Re: [PATCH] NTP ntp-helper functions
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <430E04D3.2010702@mvista.com>
References: <1124936181.20820.158.camel@cog.beaverton.ibm.com>
	 <430E04D3.2010702@mvista.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 11:06:38 -0700
Message-Id: <1124993199.20820.191.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 10:50 -0700, George Anzinger wrote:
> john stultz wrote:
> > Andrew, All,
> > 
> > 	This patch cleans up a commonly repeated set of changes to the NTP
> > state variables by adding two helper inline functions:
> > 	
> > ntp_clear(): Clears the ntp state variables
> 
> How many places is this called in any given arch?  I ask because it 
> _may_ save space if it is NOT inlined.  I don't think it is ever in a 
> critical code path...

I wouldn't mind putting it in a function either (it helps get those ntp
time_* values out of the global namespace), but I figured I'd first
clean it up without changing anything.

thanks
-john


