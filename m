Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUF0IwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUF0IwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 04:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUF0IwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 04:52:08 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32128
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261239AbUF0IwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 04:52:04 -0400
From: Rob Landley <rob@landley.net>
To: Brad Campbell <brad@wasp.net.au>
Subject: Re: Process in D state with USB and swsuspsp
Date: Sun, 27 Jun 2004 03:50:46 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200406262031.14464.rob@landley.net> <40DE5BC0.7080206@wasp.net.au>
In-Reply-To: <40DE5BC0.7080206@wasp.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406270350.46641.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 June 2004 00:31, Brad Campbell wrote:
> Rob Landley wrote:
> > As I said, I realise that unplugging even a USB adapter with the machine
> > is suspended is Not A Good Thing.  But it's likely to be a common thing
> > among people who can't figure out after the fact "oh yeah, that's what's
> > going wrong"...
>
> Most of us that use swsusp regularly have our pre-suspend script unload usb
> before suspend to prevent exactly this sort of behaviour.
> I also unload PCMCIA.
>
> If there is something using these devices that prevents unloading, then my
> script notifies me that I'm doing something I need to stop before I
> suspend. Can't remember the last time that happened though.
>
> Check out the swsusp-devel list for further info.

Yeah, I could, I just don't use USB enough.  My suspend script is now stripped 
down to the point where the only thing I do is run dhclient afterwards (and 
that's mostly because it seems to be too stupid to notice the timeout's 
elapsed.  Persumably it should have some kind of trigger if the wireless 
access point toggles...)

It's just that a hot-pluggable bus, it should be possible to convince the 
thing to reprobe all devices on a bus reset.  Oh well.

Maybe a todo item for 2.7...

Rob

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

