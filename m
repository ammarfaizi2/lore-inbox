Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUAUXQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUAUXQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:16:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:2551 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264261AbUAUXPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:15:30 -0500
Message-ID: <400F07F3.5090803@mvista.com>
Date: Wed, 21 Jan 2004 15:14:59 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
References: <200401161759.59098.amitkale@emsyssoft.com> <200401171459.01794.amitkale@emsyssoft.com> <40099301.6000202@mvista.com> <200401211916.49520.amitkale@emsyssoft.com> <20040121183940.GA23200@nevyn.them.org>
In-Reply-To: <20040121183940.GA23200@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> On Wed, Jan 21, 2004 at 07:16:48PM +0530, Amit S. Kale wrote:
> 
>>Now back to gdb problem of not being able to locate registers.
>>schedule results in code of this form:
>>
>>schedule:
>>framesetup
>>registers save
>>...
>>...
>>save registers
>>change esp
>>call switchto
>>restore registers
>>...
>>...
>>
>>GDB can't analyze code other than frame setup and registers save. It may not 
>>show values of variables that are present in registers correctly. This used 
>>to be a problem some time ago (gdb 5.X). Perhaps gdb 6.x does a better job.
>>hmm...
>>May be its time I should look at gdb's x86 register info code again.
> 
> 
> You should try GDB 6.0, which will use the dwarf2 unwind information to
> accurately locate registers in any GCC-compiled code with -gdwarf-2 (-g
> on Linux targets).
> 
> As George is now painfully familiar with :)

Well, some of that may be in asm code which may need help.  Need to check this.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

