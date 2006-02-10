Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWBJV1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWBJV1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBJV07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:26:59 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:31268 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751378AbWBJV06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:26:58 -0500
Message-ID: <43ED04E9.9040900@cfl.rr.com>
Date: Fri, 10 Feb 2006 16:26:01 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re:
 CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring
 up a hornets' nest) ]]
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com> <20060210210006.GA5585@stiffy.osknowledge.org>
In-Reply-To: <20060210210006.GA5585@stiffy.osknowledge.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 21:27:44.0439 (UTC) FILETIME=[D4A10470:01C62E88]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14260.000
X-TM-AS-Result: No--4.550000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski wrote:
> I've been waiting 30 minutes for the machine to come back but no chance. SSH
> didn't work either. I thought I could login remote... but uh uh.
>
> The problem is, it's a laptop. So there not much chance to move the cdrom device
> over to another controller or whatever. ;)
>
> But let's face it: is it really crappy to render a laptop unusable just because
> blanking a CD-RW. The circumstances were: run xcdroast via gksu (thus running as
> root), blank CD-RW. Due to cd-burning being totally unusable as a user (problems
> here and there if it was just doing anything at all). So I've no other chance
> than to run this as root. Couldn't cdrecord 'watch' ide load or - even better -
> forcecast it? It knows blanking leads to inresponsiveness sometimes (even more due
> to the fact that both devices share the same bus). Why not kind of  'renice'
> the process that blanks?
>
> Marc

If that is what is going on, there is nothing linux can do about it; 
it's a limitation of the hardware.  The IDE controller can only accept 
one command at a time, so if that command takes a while to complete, the 
other drive on the same channel can not be accessed until the first 
command completes. 

If the system doesn't come back though after sufficient time has gone by 
for the burn to complete, then this is probably not what is happening.  
I'd suggest using magic-sysreq to force an unmount and reboot, then see 
if there's anything in the logs. 


