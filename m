Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269369AbUIIINh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269369AbUIIINh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUIIINh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:13:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52476 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269369AbUIIINW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:13:22 -0400
Message-ID: <41400FAD.4050802@mvista.com>
Date: Thu, 09 Sep 2004 01:09:17 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: john stultz <johnstul@us.ibm.com>, Christoph Lameter <clameter@sgi.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> <1094700768.29408.124.camel@cog.beaverton.ibm.com> <413FDC9F.1030409@mvista.com> <200409082337.30961.jbarnes@engr.sgi.com>
In-Reply-To: <200409082337.30961.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Wednesday, September 8, 2004 9:31 pm, George Anzinger wrote:
> 
>>a.) resolution.  If you don't put a limit on this you will invite timer
>>storms. Currently, by useing 1/HZ resolution, all timer "line up" on ticks
>>and reduce the interrupt overhead that would occure if we actually tried to
>>give "exactly" what was asked for.  This is a matter of math and can be
>>handled (assuming we resist the urge to go shopping :))
> 
> 
> This can be bad though if lots of CPUs hit it at the same time or nearly so if 
> they're all trying to write the same cacheline or two.

I think that most of the SMP issues your talking about have gone away with 2.6 
where we have seperate timer lists for each cpu.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

