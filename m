Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWAFVPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWAFVPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWAFVPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:15:12 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:54918 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932523AbWAFVPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:15:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface (rev. 2)
Date: Fri, 6 Jan 2006 22:17:08 +0100
User-Agent: KMail/1.9
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200601042340.42118.rjw@sisk.pl> <20060105233026.GA3339@elf.ucw.cz>
In-Reply-To: <20060105233026.GA3339@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601062217.09012.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 6 January 2006 00:30, Pavel Machek wrote:
> > This is the second "preview release" of the swsusp userland interface patches.
> > They have changed quite a bit since the previous post, as I tried to make the
> > interface more robust against some potential user space bugs (or outright
> > attempts to abuse it).
> 
> Works for me, thanks.
> 
> Perhaps it is time to get 1/4 and 3/4 into -mm? You get my signed-off
> on them...

OK, I'll prepare them in a while.

> 2/4 needs to allocate official major/minor. 1/13 would be nice :-).

Well, you said you liked the patch with a misc device (ie. major = 10).

Actually the code is somewhat simpler in that case so I'd prefer it.

Now, if we used a misc device, which minor would be suitable?  231?

> 4/4... I'm not sure. It would be nice to make swsusp.c disappear. It
> is really wrong name. That means we need to only delete from it for a
> while...

Anyway I think it would be nice to move the code that does not really belong
to the snapshot and is used by both the user interface and disk.c/swap.c to
a separate file.  I have no preference as far as the name of the file is
concerned, though.

Greetings,
Rafael
