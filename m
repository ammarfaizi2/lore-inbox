Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUGaSAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUGaSAg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 14:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUGaSAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 14:00:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:20901 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267981AbUGaSAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 14:00:31 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <1091226922.5083.13.camel@localhost.localdomain>
	 <1091232770.1677.24.camel@mindpipe>
	 <200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1091296857.1677.286.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 14:00:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 07:34, Denis Vlasenko wrote:
> On Saturday 31 July 2004 03:12, Lee Revell wrote:
> > On Fri, 2004-07-30 at 18:35, Alan Cox wrote:
> > > On Gwe, 2004-07-30 at 20:11, Todd Poynor wrote:
> > > > IDE initialization and probing makes numerous calls to sleep for 50
> > > > milliseconds while waiting for the interface to return probe status and
> > > > such.
> > >
> > > Please make it taint the kernel if you do that so we can ignore all the
> > > bug reports. That or justify it with a cite from the ATA standards ?
> >
> > Works great on my hardware.  Well worth the savings in boot time.
> 
> Crowd of "my old crapbox no longer boots with newer kernel, wtf?" people
> won't be happy at all.
> 
> +               ide_delay = simple_strtoul(s+10,NULL,0);
> +               printk(" : Delay set to %dms\n", ide_delay);
> +               return 1;
> 

I wonder if 83 probes are really necessary.  Maybe this could be
optimized a bit.

Lee

