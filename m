Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVI1UDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVI1UDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVI1UDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:03:10 -0400
Received: from mail.tmr.com ([64.65.253.246]:63383 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750827AbVI1UDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:03:08 -0400
Message-ID: <433AF75F.2060208@tmr.com>
Date: Wed, 28 Sep 2005 16:04:47 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guy <bugzilla@watkins-home.com>
CC: "'Holger Kiehl'" <Holger.Kiehl@dwd.de>,
       "'Mark Hahn'" <hahn@physics.mcmaster.ca>,
       "'linux-raid'" <linux-raid@vger.kernel.org>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
References: <200508302305.j7UN5bE23350@www.watkins-home.com>
In-Reply-To: <200508302305.j7UN5bE23350@www.watkins-home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guy wrote:

>In most of your results, your CPU usage is very high.  Once you get to about
>90% usage, you really can't do much else, unless you can improve the CPU
>usage.
>
That seems one of the problems with software RAID, the calculations are 
done in the CPU and not dedicated hardware. As you move to the top end 
drive hardware the CPU gets to be a limit. I don't remember off the top 
of my head how threaded this code is, and if more CPUs will help.

I see you are using RAID-1 for your system stuff, did one of the tests 
use RAID-0 over all the drives? Mirroring or XOR redundancy help 
stability but hurt performance. Was the 270MB/s with RAID-0 or ???

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

