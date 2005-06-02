Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVFBWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFBWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFBWC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:02:26 -0400
Received: from web61014.mail.yahoo.com ([209.73.179.23]:20837 "HELO
	web61014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261407AbVFBWAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:00:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZpVoxbruehXqHAPEJ0CU0q5bY8B2TUW+uOpIpq9A6TuZlbLS/fPt87pf9/4xYFEZZTAikmSL3bp8jbadID+tYkjZ5Yji+D2V1H6Dlcdi/Zr0nJdPLng0P3OjJLWZ3Xtr5xTO/5BGnnZSRBe6fNJLMRqBcVNc8P3RYhBwOREr1To=  ;
Message-ID: <20050602220028.3572.qmail@web61014.mail.yahoo.com>
Date: Thu, 2 Jun 2005 15:00:27 -0700 (PDT)
From: trusted linux <tcimpl2005@yahoo.com>
Subject: Re: TPM on IBM thinkcenter S51
To: Torsten Landschoff <tla@comsys.informatik.uni-kiel.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1117459071.6058.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torsten,

thanks, here is my strace related to tpm:

open("/dev/tpm", O_RDWR)                = -1 ENODEV
(No such device)
write(2, "Can\'t open TPM Driver\n", 22Can't open TPM
Driver
) = 22

I also inserted some printk in tpm.c and tpm_nsc.c
(tpm_atmel.c as well). I only saw "init_tpm" be
called.  "tpm_open" was not even called!

This machine (IBM thinkcenter S51) has a TPM
(confirmed by IBM support and its own specs). So, the
only possible problem is the driver. Any idea?

thanks a lot,

Gang



--- Torsten Landschoff
<tla@comsys.informatik.uni-kiel.de> wrote:

> On Fri, 2005-05-27 at 13:42 -0700, trusted linux
> wrote:
>  
> > I can't make TPM work on an IBM thinkcenter S51
> > running 2.6.12-rc5 kernel. Here is what I did:
> >  
> > 1. build the drivers tpm.ko and tpm_nsc.ko and
> > modprobe tpm
> > 2. create /dev/tpm
> > 3. build tpm libtcpa (version 1.1)
> > 4. run tcpa_demo 
> >  
> > then I got an error "Can't open TPM driver". 
> 
> I'd check with strace first what's going on there.
> In my case I
> had /dev/tpm0 created by udev with libtcpa accessing
> /dev/tpm. So -
> what's the output of 
> 
> 	strace ./tcpa_demo
> 
> ??
> 
> Greetings
> 
> 	Torsten
> 
> 



		
__________________________________ 
Discover Yahoo! 
Find restaurants, movies, travel and more fun for the weekend. Check it out! 
http://discover.yahoo.com/weekend.html 

