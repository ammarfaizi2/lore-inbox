Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUGaSGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUGaSGl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 14:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267987AbUGaSGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 14:06:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47013 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267986AbUGaSFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 14:05:53 -0400
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
Message-Id: <1091297179.1677.290.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 14:06:20 -0400
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

Maybe we need a CONFIG_ANCIENT_HARDWARE that people can set if they want
to use old stuff, and anywhere in the code we take a big hit to make
some ancient device work wouldn't get compiled.  Devices could be added
to this class as they are identified.

Lee 

