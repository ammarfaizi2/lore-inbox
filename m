Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268030AbTAIT2M>; Thu, 9 Jan 2003 14:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268031AbTAIT2M>; Thu, 9 Jan 2003 14:28:12 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:9811 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S268030AbTAIT2L>;
	Thu, 9 Jan 2003 14:28:11 -0500
Message-ID: <3E1DCF8C.8060408@acm.org>
Date: Thu, 09 Jan 2003 13:37:48 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: IPMI driver
References: <200301090332.h093WML05981@hera.kernel.org> <20030109164407.GA26195@codemonkey.org.uk> <1042135594.27796.37.camel@irongate.swansea.linux.org.uk> <20030109172229.GA27288@codemonkey.org.uk> <1042135971.27796.44.camel@irongate.swansea.linux.org.uk> <3E1DCA8D.4040005@acm.org> <20030109192022.GA5693@codemonkey.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Thu, Jan 09, 2003 at 01:16:29PM -0600, Corey Minyard wrote:
>
> > >Pull the 2.5 port from openipmi.sourceforge.net  saves you doing the port
> > >yourself. 
> > >
> > Definately pull the 2.5 port from there, as there are some differences 
> > between the 2.4 and 2.5 versions.
>
>I had a quick skim through the patch.
>Is the handling of jiffies wraps done correctly ? It doesn't
>look like it...
>
>time_diff = ((jiffies_now - kcs_info->last_timeout_jiffies)
>
>		Dave
>
I don't understand why that wouldn't work.  Those are both unsigned long 
values.  Assuming twos complement, the time difference could be correct, 
even in a wraparound case (unless a very large number of jiffies has 
transpired, but that will never be the case here).

Am I missing something here?

-Corey


