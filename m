Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319791AbSIMVSs>; Fri, 13 Sep 2002 17:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319796AbSIMVSs>; Fri, 13 Sep 2002 17:18:48 -0400
Received: from mesatop.zianet.com ([216.234.192.105]:19216 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S319791AbSIMVSr> convert rfc822-to-8bit; Fri, 13 Sep 2002 17:18:47 -0400
Subject: Re: 2.5.34-mm2 kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y
From: Steven Cole <elenstev@mesatop.com>
To: Arador <diegocg@teleline.es>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20020913224139.72df14ba.diegocg@teleline.es>
References: <1031840041.1990.378.camel@spc9.esa.lanl.gov> 
	<20020913224139.72df14ba.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.2-5mdk 
Date: 13 Sep 2002 15:20:26 -0600
Message-Id: <1031952028.2604.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-13 at 14:41, Arador wrote:
> On 12 Sep 2002 08:14:01 -0600
> Steven Cole <elenstev@mesatop.com> escribió:
> 
> > I got the following BUG at sched.c:944! with 2.5.34-mm2 and PREEMPT on.
> > This was repeatable. 
> 
> Same for me:
> POSIX conformance testing by UNIFIX
> Kernel BUG at sched.c:944!
> 

If you just want a quick workaround (not a real fix), you
can change in_atomic back to in_interrupt on line 933 of kernel/sched.c.

Robert Love has posted another patch for this, so you might want to
try that out.  Here is a link to that post:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103190275327089&w=2
You may need to change KERN_ERROR to KERN_ERR in that patch.

Steven

