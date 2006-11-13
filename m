Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755274AbWKMUmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbWKMUmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbWKMUmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:42:07 -0500
Received: from sd291.sivit.org ([194.146.225.122]:25868 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1755274AbWKMUmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:42:04 -0500
Subject: Re: [PATCH] Apple Motion Sensor driver
From: Stelian Pop <stelian@popies.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061113190635.597ab587.khali@linux-fr.org>
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <20061113190635.597ab587.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 13 Nov 2006 21:41:59 +0100
Message-Id: <1163450519.23807.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 13 novembre 2006 à 19:06 +0100, Jean Delvare a écrit :
> Hi Stelian,
> 
> On Sat, 11 Nov 2006 22:36:11 +0100, Stelian Pop wrote:
> > This driver adds support for the Apple Motion Sensor (AMS) as found in 2005
> > revisions of Apple PowerBooks and iBooks.  It implements both the PMU and
> > I²C variants.  The I²C driver and mouse emulation is based on code by
> > Stelian Pop <stelian@popies.net>, while the PMU driver has been developped
> > by Michael Hanselmann <linux-kernel@hansmi.ch>. HD parking support will be
> > added later.
> > 
> > Various people contributed fixes to this driver, including
> > Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org> and
> > Jean Delvare <khali@linux-fr.org>.
> > 
> > This patch lived for a while in the -mm tree but was dropped by Andrew in
> > 2.6.18-mm1 because of some conflicting changes he was send at the time.
> > Things have settled down since then, I merged all the bits and pieces and 
> > rediffed against the latest git.
> > 
> > This driver should be quite mature to go directly into the input tree. If not,
> > Andrew please pick it up again.
> > 
> > (...)
> >  b/drivers/hwmon/ams/Makefile    |    8 +
> >  b/drivers/hwmon/ams/ams-core.c  |  265 +++++++++++++++++++++++++++++++++++
> >  b/drivers/hwmon/ams/ams-i2c.c   |  299 ++++++++++++++++++++++++++++++++++++++++
> >  b/drivers/hwmon/ams/ams-mouse.c |  147 +++++++++++++++++++
> >  b/drivers/hwmon/ams/ams-pmu.c   |  207 +++++++++++++++++++++++++++
> >  b/drivers/hwmon/ams/ams.h       |   72 +++++++++
> >  drivers/hwmon/Kconfig           |   25 +++
> >  drivers/hwmon/Makefile          |    1 
> >  8 files changed, 1024 insertions(+)
> 
> There's some confusion here. On the one hand, you placed your driver
> in the hwmon directory, and integrated it in the Hardware Monitoring
> menu. But on the other hand you seem to think that the input tree is
> the natural merge path for this patch. Isn't it strange?

This is because I got myself confused when writing that sentence
(minutes ago I was sending a patch for the appletouch driver, targeted
at the input tree).

I do believe that the proper place for ams is the hardware monitoring
section (even if the missing HD parking APIs makes it not very useful
right now).

The fact that the accelerometer offers a (low res) joystick emulation is
only a nice hack and I'm not even sure somebody (except Johannes) will
find an use for it.

-- 
Stelian Pop <stelian@popies.net>

