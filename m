Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWFYTTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWFYTTI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWFYTTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:19:08 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:63916 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751379AbWFYTTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:19:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
Date: Sun, 25 Jun 2006 21:19:27 +0200
User-Agent: KMail/1.9.3
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, sekharan@us.ibm.com,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606251051.55355.rjw@sisk.pl> <20060625032243.fcce9e2e.akpm@osdl.org>
In-Reply-To: <20060625032243.fcce9e2e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606252119.27351.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 June 2006 12:22, Andrew Morton wrote:
> On Sun, 25 Jun 2006 10:51:55 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > > 
> > > 
> > > My guess would be that cpufreq_register_driver() is being called after it
> > > has been unloaded from the kernel.
> > > 
> > > Do you have CONFIG_CPU_FREQ=y?
> > 
> > Yes.
> > 
> > > Does removal of the __cpuinit from cpufreq_register_driver() fix it (or
> > > move the crash elsewhere)?
> > 
> > Yes (makes it go away).
> 
> Well it would appear that the new __cpuinit on cpufreq_register_driver() is
> causing the problem, although I'm surprised that you don't have
> CONFIG_HOTPLUG_CPU set, if it's a swsusp requirement??

It's only required if CONFIG_SMP is set. ;-)

Greetings,
Rafael
