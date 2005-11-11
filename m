Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVKKARr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVKKARr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVKKARq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:17:46 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:45038 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932227AbVKKARp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:17:45 -0500
Message-ID: <4373E32D.20409@mvista.com>
Date: Thu, 10 Nov 2005 16:17:49 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/39] NLKD/i386 - time adjustment
References: <43720DAE.76F0.0078.0@novell.com>  <43720E2E.76F0.0078.0@novell.com>  <43720E72.76F0.0078.0@novell.com>  <43720EAF.76F0.0078.0@novell.com>  <43720F5E.76F0.0078.0@novell.com>  <43720F95.76F0.0078.0@novell.com>  <43720FBA.76F0.0078.0@novell.com>  <43720FF6.76F0.0078.0@novell.com>  <43721024.76F0.0078.0@novell.com>  <4372105B.76F0.0078.0@novell.com>  <43721081.76F0.0078.0@novell.com> <43724991.10607@mvista.com> <43730EE8.76F0.0078.0@novell.com>
In-Reply-To: <43730EE8.76F0.0078.0@novell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich wrote:
~
> 
> gcc can do long long multiplies fine, but only with a long long result.
> The code presented, however, needs (at least) 96 bits of the result,
> which expressing in C would be far more complicated than doing it with a
> couple of assembly statements.
> 
Well, if you need that many bits... guess I would need to study the code (hard with binary 
attachments) to understand why you need so many bits.
> 
>>I really do not see the relavence of the run time library patches
> 
~

> 
> Which run time library patches are you referring to? NLKD's? If so,
> these routines must not be used by code outside of the debugger (and the
> opposite is true, too: debugger code must not use common code routines
> where ever possible).

Just what is your argument here?  As I understand it this is only a problem (i.e. sharing the code) 
if you are trying to single step or set breakpoints in the library code.
> 
> Further, it is my understanding that it is for a (unknown to me) reason
> that the linux kernel doesn't have the full set of libgcc support
> routines. Since the debugger in various places relies on being able to
> do 64-bit math on 32-bit systems, I had to add these in a way so that
> they'd be hidden from the rest of the kernel (and also so that they'd
> satisfy the isolation rules outlined above).

Well, the powers that be, decided that the kernel did not need the "missing" routines and that they 
just added bloat.  One then wonders why a debugger needs them.  Could you enlighten us on this?

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
