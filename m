Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWIUWSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWIUWSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWIUWSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:18:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:3506 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751645AbWIUWSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:18:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 4/6] swsusp: Add resume_offset command line parameter
Date: Fri, 22 Sep 2006 00:18:44 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200609202120.58082.rjw@sisk.pl> <200609202146.59105.rjw@sisk.pl> <20060921213143.GE2245@elf.ucw.cz>
In-Reply-To: <20060921213143.GE2245@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609220018.45198.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 September 2006 23:31, Pavel Machek wrote:
> Hi!
> 
> > Add the kernel command line parameter "resume_offset=" allowing us to specify
> > the offset, in <PAGE_SIZE> units, from the beginning of the partition pointed
> > to by the "resume=" parameter at which the swap header is located.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Okay, I'd prefer not to add aditional features to in-kernel swsusp,
> but this is just not big enough to reject.
> 
> ACK.
> 
> (What is the solution for uswsusp?)

We need an additional ioctl to set both the swap partition and "resume offset"
at a time (the one we currently have allows us only to set the partition and I
don't want to change it because of the backwards compatibility, but I think
I'll change its name ;-) ).

I'd like to add this ioctl along with the one needed to support the "platform"
method of powering off, because it will require some similar documentation
changes (most importantly, the description of the interface in
Documentation/ABI which I'd like to add once and not to tamper with
afterwards).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

