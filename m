Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVKITKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVKITKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVKITKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:10:04 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:63474 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030286AbVKITKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:10:01 -0500
Message-ID: <43724991.10607@mvista.com>
Date: Wed, 09 Nov 2005 11:10:09 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/39] NLKD/i386 - time adjustment
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com> <43720F95.76F0.0078.0@novell.com> <43720FBA.76F0.0078.0@novell.com> <43720FF6.76F0.0078.0@novell.com> <43721024.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <43721081.76F0.0078.0@novell.com>
In-Reply-To: <43721081.76F0.0078.0@novell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich wrote:
> Since i386 time handling is not overflow-safe, these are the
> adjustments needed for allowing debuggers to update time after
> having halted the system for perhaps extended periods of time.
> 
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
> 
> (actual patch attached)

The patch includes code that seems to imply that gcc can not do mpy of (long long) variables.  It 
does just fine with these.  It also adds (long long) types just fine.  The only problem it has is 
with div, for which we have do_div().

I really do not see the relavence of the run time library patches given the above.  The adjust code 
does not seem to use them.  Also, gcc (with the lib code) does all of this stuff.  The only need for 
it would, possibly, be to debug the library code and even then, I suspect you really want to do that 
in user land and then bring the result into the kernel.

Am I missing something?
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
