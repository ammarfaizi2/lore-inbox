Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWFVWsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWFVWsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWFVWsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:48:00 -0400
Received: from web33315.mail.mud.yahoo.com ([68.142.206.130]:19349 "HELO
	web33315.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750992AbWFVWr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:47:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0ESDXiwZp7X51vIXtUPdYOUq1dBK4c3hCnxiRzstPPvur9IraViB9dL345FkybqrIUGzBsRLW7IRpPGZr+uNPT9NgtyZpBqqoBBxvFtFl1uSdy+aDzRy8yplS0CZHvFFYpOFJJuPBNVG8AQ6P9UfGaZlRBAntojKy2Qd7aMpC24=  ;
Message-ID: <20060622224759.25253.qmail@web33315.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 15:47:59 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Measuring tools - top and interrupts
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060622175724.GA28913@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Francois Romieu <romieu@fr.zoreil.com> wrote:

> Danial Thom <danial_thom@yahoo.com> :
> [bull removed]
> 
> You have been told twice in this thread to use
> vmstat.
> 
> Read again and shut up until you can provide a
> sensible bug report,
> thank you.

vmstat gives the same #s as top, and it doesn't
break down the interrupts, so its not the answer
to the question "is there something similar to
systat". Plus its clear that the guy who gave the
answer doesn't know what he's talking about,
since he's actually trying to explain away the
problem as being normal. 

Here's a sensible bug report. Bridging 75K pps.
vmstat output:

 0  0      0 425424   9984  40496    0    0     0
    0 16238    12  0  0 100  0
 0  0      0 425424   9984  40496    0    0     0
    0 16227    16  0  0 100  0
 0  0      0 425424   9984  40496    0    0     0
    0 16244     9  0  0 100  0

Over 16,000 interrupts per second and 100% idle. 

netstat:

eth2   1500   0       5      0      0      468886
     0      0      0 BMRU
eth3   1500   473201      0   5680      0       5
     0      0      0 BMRU

the system is perpetually 100% idle but its
dropping packets due to excessive backlog.

DT


> 
> -- 
> Ueimor
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to
> majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at 
> http://www.tux.org/lkml/
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
