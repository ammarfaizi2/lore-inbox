Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUJXBlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUJXBlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 21:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbUJXBlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 21:41:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:37533 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261353AbUJXBlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 21:41:04 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Lee Revell <rlrevell@joe-job.com>
To: jonathan@jonmasters.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <35fb2e5904102316177420f6a9@mail.gmail.com>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
	 <1098566366.24804.8.camel@localhost.localdomain>
	 <1098571334.29081.21.camel@krustophenia.net>
	 <35fb2e5904102316177420f6a9@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 23 Oct 2004 21:40:56 -0400
Message-Id: <1098582057.29081.157.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 00:17 +0100, Jon Masters wrote:
> On Sat, 23 Oct 2004 18:42:13 -0400, Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Does anyone know how OSX/CoreAudio handles the situation?  Apparently
> > realtime apps work flawlessly on speed scaling laptops under OSX.
> 
> The difference in implementation between the Intel TSC and PowerPC
> TB[LU] has been mentioned previously in this thread.

Well, it was mentioned that there is a difference...

http://www-106.ibm.com/developerworks/eserver/pdfs/archpub2.pdf

pg. 39, "Non-constant update frequency".

"Each time the update frequency changes, the system software is notified
of the change via an interrupt, or the change was instigated by the
system software itself.  At each such change, the system software must
compute the current time of day using the old update frequency, compute
a new value of ticks_per_sec for the new frequency, and save the time of
day, Time Base value, and the tick rate"

This was what I wanted to know: does Linux and/or the x86 have a similar
mechanism?  Looks like the answer is no...

Lee

