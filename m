Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbVKXDUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbVKXDUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbVKXDUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:20:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:60838
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932621AbVKXDUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:20:01 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Wed, 23 Nov 2005 21:19:46 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511230258.33901.rob@landley.net> <20051123132106.GC23159@elf.ucw.cz>
In-Reply-To: <20051123132106.GC23159@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232119.46383.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 07:21, Pavel Machek wrote:
> Hi!
>
> > > Sorry, I did not have time to look what's wrong with miniconfig, yet.
> >
> > I just tried again and it applied to -git2 cleanly.  Possibly it was
> > whitespace damaged?  (I have to jump through hoops to prevent kmail from
> > doing stupid things to inline attachments...)
> >
> > Here it is as an attachment.  Let me know if this applies cleanly
> > for you...
>
> Ok, this one applied okay for me. It still does not seem to work:
>
> pavel@amd:/data/l/linux$ scripts/miniconfig.sh config.ok
> Calculating mini.config...
> pavel@amd:/data/l/linux$ cat mini.config
> CONFIG_PM=y
> pavel@amd:/data/l/linux$
>
> ...and yes, my config is definitely more complex than that, I
> handselected only relevant PCI cards, for example.
>        Pavel

Odd.

The way the script works is it repeatedly calls "make miniconfig" to see if 
removing each line makes a difference.  Judging by the output, it thinks none 
of the lines it removed made any difference.

Could you send me the .config you tried to shrink down?

Rob
