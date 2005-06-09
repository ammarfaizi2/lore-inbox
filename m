Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVFIX7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVFIX7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVFIX7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:59:00 -0400
Received: from dvhart.com ([64.146.134.43]:61352 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261628AbVFIX5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:57:04 -0400
Date: Thu, 09 Jun 2005 16:56:56 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <1100910000.1118361416@flay>
In-Reply-To: <20050607170853.3f81007a.akpm@osdl.org>
References: <1004450000.1118188239@flay><20050607165656.2517b417.akpm@osdl.org><Pine.LNX.4.62.0506071659580.30849@schroedinger.engr.sgi.com> <20050607170853.3f81007a.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, June 07, 2005 17:08:53 -0700 Andrew Morton <akpm@osdl.org> wrote:

> Christoph Lameter <clameter@engr.sgi.com> wrote:
>> 
>> On Tue, 7 Jun 2005, Andrew Morton wrote:
>> 
>> > > Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
>> > 
>> > Oh crap, so it does.  That's wrong.
>> 
>> Email by you and Linus indicated that 250 should be the default.
> 
> Oh, OK. hrm.
> 
> Martin, it would be useful if you could determine whether the kernbench
> slowdown was due to the 1000Hz->250Hz change, thanks.
> 
> I'm assuming it was the CPU scheduler patches.  There are 36 of them ;)

Backed them all out ... performance thunks down to earth again, and is actually
the best I've seen it ever (probably 250Hz is helping, I used to run 100 in 
-mjb for better benefit).

the +5081 item is the one to look at
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.moe.png

Patch I used was here:

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/patches/nosched

But it was just everything under the "CPU scheduler" section of your series
file.

M.

