Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUEJMUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUEJMUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264661AbUEJMUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:20:13 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:24767 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264658AbUEJMUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:20:09 -0400
Message-ID: <409F7377.3030308@yahoo.com.au>
Date: Mon, 10 May 2004 22:20:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm1
References: <20040510024506.1a9023b6.akpm@osdl.org> <200405101252.33205.dominik.karall@gmx.net> <20040510111845.GB21671@redhat.com>
In-Reply-To: <20040510111845.GB21671@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, May 10, 2004 at 12:52:33PM +0200, Dominik Karall wrote:
>  > 
>  >   CC      arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
>  > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In Funktion >>cpufreq_p4_get<<:
>  > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: `sibling' undeclared 
>  > (first use in this function)
>  > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: (Each undeclared 
>  > identifier is reported only once
>  > arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:283: error: for each function it 
>  > appears in.)
>  > make[4]: *** [arch/i386/kernel/cpu/cpufreq/p4-clockmod.o] Fehler 1
> 
> Oops.
> 

In -mm, cpu_sibling_map is a cpumask_t with cpu_sibling_map[cpu]
containing "cpu" and all of its siblings.

Linus' tree looks like it is going to be that way shortly too.

Nick
