Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWCCQHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWCCQHz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWCCQHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:07:54 -0500
Received: from natblindhugh.rzone.de ([81.169.145.175]:43516 "EHLO
	natblindhugh.rzone.de") by vger.kernel.org with ESMTP
	id S1030228AbWCCQHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:07:54 -0500
To: linux-kernel@vger.kernel.org
From: jfock@abas-projektierung.de
Subject: Re-2: oom-killer: gfp_mask=0xd1  with 2.6.12 on EM64T
Date: 03 Mar 2006 16:03:04 UT
X-Priority: 3 (Normal)
Importance: normal
X-Mailer: DvISE by Tobit Software, Germany (0224.434647444B47474D4E51)
X-David-Sym: 0
X-David-Flags: 0
Message-ID: <000702D2.440876C7@192.168.222.27>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="iso-8859-1"
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have The same Problem with a Maxdata Server 5220l with 8GB memory 2 Intel Xeon Processors und an Intel Raidcontroler
Since im Using Linux-2.6.15.4 from Kernel.org my System is OK
Johann
Abas Projektierung GmbH



-------- Original Message --------
Subject: Re: oom-killer: gfp_mask=0xd1  with 2.6.12 on EM64T (03-Mrz-2006 16:50)
From:    jmce@artenumerica.com
To:      jfock@abas-projektierung.de

> Andrew Morton wrote:
> > That's quite an old kernel.  If this is the notorious bio-uses-GFP_DMA bug
> > then I'd have expected this kernel to be useless from day one.  Did you
> > install it recently?
> 
> On this double Xeon, yes.  I had no problems before with 2.6.12 and the
> same "heavy" software on dual Opteron and dual dual core Opteron
> machines, and this is my first installation on a EM64T.
> At first it seemed everything was ok with 2.6.12 here too, but in a
> couple of days we started gettings some of those oom killings when
> running some Gaussian jobs. In at least a pair of cases the system froze
> completely.
> 
> > If you're feeling keen you could add this patch which would confirm it:
> 
> Added it and already got output for a similar "killing". Since I'm not
> sure what could be most relevant among those messages, I refrained from
> attaching them all here, and instead put them at
> http://jmce.artenumerica.org/tmp/linux-2.6.12-oom_killings/EM64T-kern.log
> 
> > And if it's that bug then I'm afraid you'll have to sit tight until 2.6.16.
> > We shouldn't release 2.6.16 until this thing is fixed.
> 
> Do those call traces suggest that uncorrected bug you mention?
> (And if yes, is there any known way to mitigate the problem? Could it
> depend on BIOS settings?)
> I'll also be able to try a 2.6.15 kernel (eventually with any suggested
> patches) later today...
> 
> Thanks again and best regards
> 
>                     J Esteves
> -- 
> +351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce
> 


To: jmce@artenumerica.com
    linux-kernel@vger.kernel.org
Cc: support@artenumerica.com
    ngalamba@fc.ul.pt

