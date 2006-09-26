Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWIZTyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWIZTyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWIZTyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:54:09 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:24799 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932246AbWIZTyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:54:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Date: Tue, 26 Sep 2006 21:56:55 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
References: <20060925071338.GD9869@suse.de> <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz>
In-Reply-To: <20060925224500.GB2540@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262156.56274.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 September 2006 00:45, Pavel Machek wrote:
> Hi!
> 
> On Mon 2006-09-25 14:45:58, Andrew Morton wrote:
> > On Tue, 26 Sep 2006 07:34:03 +1000
> > Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> > 
> > > </rant>
> > 
> > metoo!  I'd suggest that it'd be better to be expending the grey cells on
> > making the present suspend stuff nice and solid, stable and fast.
> 
> [Un?]fortunately, Novell has some suggestions how I should expend my
> grey cells in this area.
> 
> Anyway you want:
> 
> nice)
> 	not sure if me + Rafael can do much here. Perhaps someone else
> 	has to go through the code and rewrite it one more time? Or do
> 	you have specific areas where suspend is really ugly?
> 
> solid)
> 	apart from HIGHMEM64G fiasco, and related agpgart fiasco long
> 	time before that... these are driver problems...
> 
> stable)
> 	I believe we are doing pretty well in this area. We did not
> 	have too many regressions, did we? (And notice that nice+fast
> 	are actually both conflicting goals with stable).
> 
> fast)
> 	frankly, that is not my priority for in-kernel
> 	suspend. uswsusp will always be few seconds faster, thanks to
> 	LZW. If we do 40MB/sec or 50MB/sec during write is not that
> 	important. Patches are always welcome.

Actually, swsusp with the speed-up patches requires quite a lot of RAM to
write to disk asynchronously.  This effectively means that on my box the image
size should not exceed 3/8 of the total RAM size, or the synchronous writing
will start due to the lack of memory.

uswsusp doesn't seem to have this problem.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
