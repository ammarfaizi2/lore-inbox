Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVJDCAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVJDCAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 22:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVJDCAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 22:00:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40181 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932195AbVJDCAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 22:00:32 -0400
Message-ID: <4341E206.3090204@mvista.com>
Date: Mon, 03 Oct 2005 18:59:34 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509301825290.3728@scrub.home> <20051001112233.GA18462@elte.hu>
In-Reply-To: <20051001112233.GA18462@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Roman Zippel <zippel@linux-m68k.org> wrote:
> > 
>>The other thing is that this assumes, that all time sources are 
>>programmable per cpu, otherwise it will be more complicated for a time 
>>source to run the timers for every cpu, I don't know how safe that 
>>assumption is. Changing the array of structures into an array of 
>>pointers to the structures would allow to switch between percpu bases 
>>and a single base.
> 
> 
> yeah, and that's an assumption that simplifies things on SMP 
> significantly. PIT on SMP systems for HRT is so gross that it's not 
> funny. If anyone wants to revive that notion, please do a separate patch 
> and make the case convincing enough ...
> 
Lets not talk about PIT, but, a lot of SMP platforms do NOT have per cpu timers.  For those, it 
would seem having per cpu lists to handle the timer is not really reasonable.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
