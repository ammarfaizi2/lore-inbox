Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318470AbSGSIVW>; Fri, 19 Jul 2002 04:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318464AbSGSIVU>; Fri, 19 Jul 2002 04:21:20 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:40079 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318471AbSGSIVS>; Fri, 19 Jul 2002 04:21:18 -0400
Date: Fri, 19 Jul 2002 10:24:12 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Yann Dirson <ydirson@altern.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Generic modules documentation is outdated
Message-ID: <20020719082412.GA6490@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Yann Dirson <ydirson@altern.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020704212240.GB659@bylbo.nowhere.earth> <20020718210259.GJ19580@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718210259.GJ19580@bylbo.nowhere.earth>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:02:59PM +0200, Yann Dirson wrote:

> I dicovered that I could "echo 0 >
> /proc/sys/kernel/tainted"
> 
>  => is this reasonable ?

Yes, if you are smart enough to do this you could also edit the oops
report or even patch nvidia licence tag etc. It's just a help to
the kernel developers to sort out newbie bug reports, nothing more.

>  => isn't there a mechanism that triggers a kernel log when "tainted" is set ?  
>     Any reason for not having one ?

There is no internal kernel function being called in order to 
initialise this flag. insmod just sets the value of the symbol, it
doesn't call a kernel function which could make an entry into the logs.

However, insmod can and should IMHO syslog this. 

> - In 2.4.18 I can't find any information about the modules licencing issues
> in Documentation/modules.txt (nor in Documentation/kmod.txt, but I don't
> feel this one would be the place for this, correct me if I'm wrong)

See Documentation/oops-tracing.txt and Documentation/sysctl/kernel.txt
(in 2.4.19-rc2 at least).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
