Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131798AbRCUWLF>; Wed, 21 Mar 2001 17:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131799AbRCUWKq>; Wed, 21 Mar 2001 17:10:46 -0500
Received: from smtp-rt-9.wanadoo.fr ([193.252.19.55]:55270 "EHLO
	alisier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S131798AbRCUWKk>; Wed, 21 Mar 2001 17:10:40 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
Date: Wed, 21 Mar 2001 23:09:31 +0100
Message-Id: <20010321220931.30095@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.31.0103210900050.2648-100000@linux.local>
In-Reply-To: <Pine.LNX.4.31.0103210900050.2648-100000@linux.local>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>I need to ask you where is this code? I like to take a look at it to
>figure out what you are doing.

You can find the mach64 sleep notifier in atyfb.c (under
CONFIG_POWERBOOK) , the code
that calls sleep notifiers is in drivers/macintosh/via-pmu.c (the various
sleep functions).

The current mach64 & chipsfb notifiers don't do anything to fbcon (they don't
stop the cursor timer neither). I have some WIP progress code in my local
tree that
implements sleep support for more recent models with a notifier in
aty128fb too.
I added some fbcon suspend/resume routines for the cursor, but they are
currently
called from my aty128fb sleep notifier, which is wrong.

Ben.


